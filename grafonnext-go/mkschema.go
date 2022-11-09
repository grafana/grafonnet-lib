package main

import (
	"bytes"
	"encoding/json"
	"fmt"
	"os"
	"path/filepath"
	"strings"

	"cuelang.org/go/cue/ast"
	"github.com/grafana/grafana/pkg/cuectx"
	"github.com/grafana/grafana/pkg/plugins/pfs/corelist"
	"github.com/grafana/grafana/pkg/registry/corekind"
	"github.com/grafana/thema/encoding/jsonschema"
)

// this is a meaningless hack, we have to work out versioning
var grafanaVersion = "latest"

var rt = cuectx.GrafanaThemaRuntime()

func main() {
	// All core kinds first
	base := filepath.Join("..", "grafonnext", "schemas", grafanaVersion, "core")
	die(os.MkdirAll(base, 0777))

	for _, kind := range corekind.NewBase(nil).AllStructured() {
		f, err := jsonschema.GenerateSchema(kind.Lineage().Latest())
		if err != nil {
			die(fmt.Errorf("%s: %w", kind.Name(), err))
		}

		b := marshalindent(f)
		path := filepath.Join(base, kind.MachineName()+".json")
		die(os.WriteFile(path, b, 0644))
	}

	// Now, all composable kinds from plugins. (Note that core grafana hasn't been refactored
	// to use 'composable kind' naming for its various methods yet)
	for _, ptree := range corelist.New(nil) {
		for slot, lin := range ptree.RootPlugin().SlotImplementations() {
			f, err := jsonschema.GenerateSchema(lin.Latest())
			if err != nil {
				// There's a bug in generating openapi from Thema with imports are loaded.
				// Normally an edge case in Thema, but needed in Grafana. Commenting this out
				// until bug is fixed and just dropping errors instead
				// die(fmt.Errorf("%s: %w", ptree.RootPlugin().Meta().Id, err))
				continue
			}

			b := marshalindent(f)
			basecompo := filepath.Join("..", "grafonnext", "schemas", grafanaVersion, "composable", strings.ToLower(slot))
			path := filepath.Join(basecompo, ptree.RootPlugin().Meta().Id+".json")
			die(os.MkdirAll(basecompo, 0777))
			die(os.WriteFile(path, b, 0644))
		}
	}
}

func die(err error) {
	if err != nil {
		fmt.Fprint(os.Stderr, err, "\n")
		os.Exit(1)
	}
}

func marshalindent(f *ast.File) []byte {
	b, _ := rt.Context().BuildFile(f).MarshalJSON()
	nb := new(bytes.Buffer)
	die(json.Indent(nb, b, "", "  "))
	return nb.Bytes()
}
