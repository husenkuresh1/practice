package cmd

import (
	"fmt"
	"go-exercise/models"
	"os"
	"reflect"
	"text/tabwriter"

	"github.com/spf13/cobra"
)

var OperatingCount = make(map[string]int)

// type  struct {
// 	StationName   string
// 	StatationCode string
// 	Count         int
// }

var scheduleCommand = &cobra.Command{
	Use:   "schedules",
	Short: "List stations with the count of operating trains.",
	Long: `List stations with the count of operating trains.
	
	For example: go-exercise operating-count`,

	Run: schedules,
}

func init() {
	rootCmd.AddCommand(scheduleCommand)

	scheduleCommand.Flags().BoolP("operating-count", "o", false, "List stations with the count of operating trains.")
	scheduleCommand.Flags().IntP("train", "T", 0, "prints schedule information of provided train number")

}

func schedules(cmd *cobra.Command, args []string) {

	trainSchedule, err := models.LoadScheduleFromCSV("/home/husen.kureshi/training/GO/go-exercise/Husen-Kureshi/GO-exercise/csv/train_schedule.csv")

	if err != nil {
		fmt.Println("error in read or fetch data")
		panic(err)
	}

	// for check flag of operating count
	isOperatingCount, err := cmd.Flags().GetBool("operating-count")

	if err != nil {
		fmt.Println("error in fetch operating-count flag")
		panic(err)
	}

	if isOperatingCount {
		printOperatingCount(trainSchedule)
	}

	// for check flag of train
	isTrainNo, err := cmd.Flags().GetInt("train")

	if err != nil {
		fmt.Println("error in fetch operating-count flag")
		panic(err)
	}
	if isTrainNo > 0 {

		printScheduleOfTrain(trainSchedule, isTrainNo)
	}

}

// print operating count of station
func printOperatingCount(trainSchedule []models.Schedule) {

	for _, value := range trainSchedule {

		if _, available := OperatingCount[value.StatationCode]; available {

			OperatingCount[value.StatationCode]++
		} else {
			OperatingCount[value.StatationCode] = 1
		}
	}

	w := tabwriter.NewWriter(os.Stdout, 0, 0, 4, ' ', tabwriter.Debug)

	fmt.Fprintf(w, "%s\t%s\t", "Station", "Operating Count")
	fmt.Fprintf(w, "\n")

	for key, value := range OperatingCount {

		fmt.Fprintf(w, "%s\t", key)
		fmt.Fprintf(w, "%v\t", value)
		fmt.Fprintf(w, "\n")

	}

	fmt.Fprintf(w, "\n")

	w.Flush()
}

// print schedule of tarin
func printScheduleOfTrain(trainSchedule []models.Schedule, trainNo int) {

	var foundflag = false

	w := tabwriter.NewWriter(os.Stdout, 0, 0, 4, ' ', tabwriter.Debug)

	typeof := reflect.TypeOf(trainSchedule[0])

	for i := 0; i < typeof.NumField(); i++ {
		fmt.Fprintf(w, "%s\t", typeof.Field(i).Name)
	}

	fmt.Fprintf(w, "\n")

	for _, value := range trainSchedule {

		if value.TrainNo == trainNo {

			foundflag = true
			v := reflect.ValueOf(value)
			for i := 0; i < v.NumField(); i++ {

				fmt.Fprintf(w, "%v\t", v.Field(i))

			}
			fmt.Fprintf(w, "\n")
		}
	}

	if !foundflag {
		fmt.Println("Train number not found in records")
	}

	w.Flush()

}
