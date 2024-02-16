package models

import (
	"encoding/csv"
	"fmt"
	"io"
	"os"
	"reflect"
	"text/tabwriter"

	"github.com/jszwec/csvutil"
)

var Trains []Train

type Train struct {
	TrainNo            int
	TrainName          string
	SourceStation      string
	DestinationStation string
	Days               string
}

type TrainModel struct {
}

func LoadDataFromCSV(filePath string) ([]Train, error) {

	// open csv file
	file, err := os.Open(filePath)

	// handling open file error
	if err != nil {
		return nil, err
	}

	// closing file
	defer file.Close()

	// initializing file reader
	reader := csv.NewReader(file)

	trainHeader, err := csvutil.Header(Train{}, "csv")

	if err != nil {
		return nil, err
	}

	dec, err := csvutil.NewDecoder(reader, trainHeader...)

	if err != nil {
		return nil, err
	}

	for {
		var t Train
		if err := dec.Decode(&t); err == io.EOF {
			break
		}
		Trains = append(Trains, t)
	}

	return Trains, nil
}

func ListAndPrint(train []Train) {
	w := tabwriter.NewWriter(os.Stdout, 0, 0, 4, ' ', tabwriter.Debug)

	typeof := reflect.TypeOf(train[0])
	for i := 0; i < typeof.NumField(); i++ {
		fmt.Fprintf(w, "%s\t", typeof.Field(i).Name)
	}

	fmt.Fprintf(w, "\n")

	for i := 0; i < len(train); i++ {

		v := reflect.ValueOf(train[i])
		for i := 0; i < v.NumField(); i++ {
			fmt.Fprintf(w, "%v\t", v.Field(i))
		}
		fmt.Fprintf(w, "\n")
	}

	w.Flush()
}
