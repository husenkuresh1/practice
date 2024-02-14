package cmd

import (
	"fmt"

	"go-exercise/models"

	"github.com/spf13/cobra"
)

// import (
// 	"encoding/csv"
// 	"fmt"
// 	"os"
// 	"strconv"

// 	"github.com/spf13/cobra"
// )

// type TrainStruct struct {
// 	trainNo            int
// 	trainName          string
// 	sourceStation      string
// 	destinationStation string
// 	days               string
// }

var listCommand = &cobra.Command{
	Use:   "list-train",
	Short: "List trains with total.",
	Long:  "List trains with total.",
	Run:   listTrain,
}

func init() {
	rootCmd.AddCommand(listCommand)

	listCommand.Flags().BoolP("total", "t", true, "Display total count of total trains")
}

func listTrain(cmd *cobra.Command, args []string) {

	isTotal, _ := cmd.Flags().GetBool("total")
	limit, _ := cmd.Flags().GetInt("limit")
	skip, _ := cmd.Flags().GetInt("skip")
	order, _ := cmd.Flags().GetString("order")
	orderBy, _ := cmd.Flags().GetString("order-by")
	selects, _ := cmd.Flags().GetStringSlice("selects")

	// read csv file using trainInfo() returns slice of trains and error
	trainSlice, err := models.TrainInfo()

	// handling file open or fetching record error
	if err != nil {
		fmt.Println("----ERROR-----")
		panic(err)
	}

	if isTotal {
		fmt.Println("*****Total Trains*****")
		fmt.Println(len(trainSlice))
	}

	models.PrintTrainStruct(trainSlice, limit, skip+1, order, orderBy, selects)

}
