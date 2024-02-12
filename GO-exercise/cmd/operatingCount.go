package cmd

import (
	"github.com/spf13/cobra"
)

var operatingCommand = &cobra.Command{
	Use:   "operating-count",
	Short: "List stations with the count of operating trains.",
	Long: `List stations with the count of operating trains.
	
	For example: go-exercise operating-count`,

	Run: operatingCount,
}

func init() {
	rootCmd.AddCommand(operatingCommand)
}

func operatingCount(cmd *cobra.Command, args []string) {

	// read csv file using trainInfo() returns slice of trains and error
	// trainSlice, err := trainInfo()

	// handling file open or fetching record error
	// if err != nil {
	// 	fmt.Println("----ERROR-----")
	// 	panic(err)
	// }

	//
	// fmt.Println(trainSlice)

}
