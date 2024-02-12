package cmd

import (
	"fmt"

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

	fmt.Println(limit)
	fmt.Println(skip)
	fmt.Println(order)
	fmt.Println(orderBy)
	fmt.Println(selects)

	// read csv file using trainInfo() returns slice of trains and error
	trainSlice, err := trainInfo()

	// handling file open or fetching record error
	if err != nil {
		fmt.Println("----ERROR-----")
		panic(err)
	}

	if isTotal {
		fmt.Println("*****Total Trains*****")
		fmt.Println(len(trainSlice))
	}

	for index, value := range trainSlice {
		if limit > 0 && index > limit {
			break
		}
		fmt.Println(value)
	}

}
