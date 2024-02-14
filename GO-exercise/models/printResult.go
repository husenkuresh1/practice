package models

import (
	"fmt"
	"os"
	"reflect"
	"text/tabwriter"
)

func PrintTrainStruct(result []TrainStruct, limit int, skip int, order string, orderBy string, selects []string) {

	noOfIteration := limit
	if limit <= 0 {
		noOfIteration = len(result)
	}

	trainStructMap := make(map[string]int)

	trainStructMap["TrainNo"] = 1
	trainStructMap["TrainName"] = 2
	trainStructMap["SourceStation"] = 3
	trainStructMap["DestinationStation"] = 4
	trainStructMap["Days"] = 5

	// refrence from direct source not mine
	w := tabwriter.NewWriter(os.Stdout, 0, 0, 4, ' ', tabwriter.Debug)
	t := reflect.TypeOf(result[0])
	for i := 0; i < t.NumField(); i++ {
		fmt.Fprintf(w, "%s\t", t.Field(i).Name)
	}

	fmt.Fprintf(w, "\n")
	for i := skip; i < noOfIteration; i++ {
		v := reflect.ValueOf(result[i])
		for i := 0; i < v.NumField(); i++ {
			fmt.Fprintf(w, "%v\t", v.Field(i))
		}
		fmt.Fprintf(w, "\n")
	}

	w.Flush()
}
