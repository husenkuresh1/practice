package models

// importing packages
import (
	"encoding/csv"
	"io"
	"os"

	"github.com/jszwec/csvutil"
)

// structure for train_info.csv file
type TrainStruct struct {
	TrainNo            int
	TrainName          string
	SourceStation      string
	DestinationStation string
	Days               string
}

// trainInfo function return the slice of all recods of train.
func TrainInfo() ([]TrainStruct, error) {

	// declare trains slice of TrainStruct type
	var trains []TrainStruct

	// open csv file
	file, err := os.Open("/home/husen.kureshi/training/GO/go-exercise/Husen-Kureshi/GO-exercise/csv/train_info.csv")

	// handling open file error
	if err != nil {
		return nil, err
	}

	// closing file
	defer file.Close()

	// initializing file reader
	reader := csv.NewReader(file)

	userHeader, err := csvutil.Header(TrainStruct{}, "csv")

	if err != nil {
		return nil, err
	}

	dec, err := csvutil.NewDecoder(reader, userHeader...)

	if err != nil {
		return nil, err
	}

	for {
		var t TrainStruct
		if err := dec.Decode(&t); err == io.EOF {
			break
		}
		trains = append(trains, t)
	}

	return trains, nil
}
