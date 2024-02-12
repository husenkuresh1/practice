package cmd

// importing packages
import (
	"encoding/csv"
	"os"
	"strconv"
)

// structure for train_info.csv file
type TrainStruct struct {
	trainNo            int
	trainName          string
	sourceStation      string
	destinationStation string
	days               string
}

// trainInfo function return the slice of all recods of train.
func trainInfo() ([]TrainStruct, error) {
	
	// declare trains slice of TrainStruct type
	var trains []TrainStruct

	// open csv file
	file, err := os.Open("/home/husen.kureshi/training/GO/go-training/go-exercise/archive/train_info.csv")

	// handling open file error
	if err != nil {
		return nil, err
	}

	// closing file
	defer file.Close()

	// initializing file reader
	reader := csv.NewReader(file)

	//  read all records from the file
	records, err := reader.ReadAll()

	// handling file read error
	if err != nil {
		return nil, err
	}

	// fetching each record from records
	for _, record := range records {

		// convert train_no string to int
		trainNoStrtoInt, _ := strconv.Atoi(record[0])

		// initializing train struct type variable using record
		train := TrainStruct{
			trainNo:            trainNoStrtoInt,
			trainName:          record[1],
			sourceStation:      record[2],
			destinationStation: record[3],
			days:               record[4],
		}

		// append the trains with each train record
		trains = append(trains, train)
	}

	return trains, nil
}
