package models

import (
	"fmt"
	"os"
	"reflect"
	"text/tabwriter"
)

func PrintTrainStruct(result []TrainStruct, limit int, skip int, order string, orderBy string, selects []string) {

	numberOfIteration := limit + skip
	if limit <= 0 {
		numberOfIteration = len(result)
	}
	
	// refrence from direct source not mine
	w := tabwriter.NewWriter(os.Stdout, 0, 0, 4, ' ', tabwriter.Debug)

	t := reflect.TypeOf(result[0])
	for i := 0; i < t.NumField(); i++ {
		fmt.Fprintf(w, "%s\t", t.Field(i).Name)
	}

	fmt.Fprintf(w, "\n")

	for i := skip; i < numberOfIteration; i++ {
		
		v := reflect.ValueOf(result[i])
		for i := 0; i < v.NumField(); i++ {
			fmt.Fprintf(w, "%v\t", v.Field(i))
		}
		fmt.Fprintf(w, "\n")
	}

	w.Flush()
}
