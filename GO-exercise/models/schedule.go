package models

import (
	"encoding/csv"
	"fmt"
	"io"
	"os"

	"github.com/jszwec/csvutil"
)

type Schedule struct {
	SN            int
	TrainNo       int
	StatationCode string
	FirstAC       int
	SecondAC      int
	ThirdAC       int
	SL            int
	StationName   string
	RouteNumber   int
	ArrivalTime   string
	DepatureTime  string
	Distance      int
}

var Schedules []Schedule

func LoadScheduleFromCSV(filepath string) ([]Schedule, error) {
	// open csv file
	file, err := os.Open(filepath)

	// handling open file error
	if err != nil {
		return nil, err
	}

	// closing file
	defer file.Close()

	// initializing file reader
	reader := csv.NewReader(file)

	scheduleHeader, err := csvutil.Header(Schedule{}, "csv")

	fmt.Println(scheduleHeader)

	if err != nil {
		return nil, err
	}

	dec, err := csvutil.NewDecoder(reader, scheduleHeader...)

	if err != nil {
		return nil, err
	}

	for {
		var t Schedule
		if err := dec.Decode(&t); err == io.EOF {
			break
		}
		Schedules = append(Schedules, t)
	}

	return Schedules, nil
}
