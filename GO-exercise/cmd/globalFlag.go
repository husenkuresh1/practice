package cmd

// import "fmt"

// --skip flag is used to skip the N records.
// --limit flag is used to limit the M records.
// --order flag is used for ASC | DSC orders.
// --order-by flag defines the column on which order is applied.
// --selects=col1,col2 prints only col1, and col2 out of the whole table.

var (
	skip    int
	limit   int
	order   string
	orderBy string
	selects []string
)

func init() {
	rootCmd.PersistentFlags().IntVar(&skip, "skip", 0, "Skip the N records")
	rootCmd.PersistentFlags().IntVar(&limit, "limit", 0, "Limit the number of records")
	rootCmd.PersistentFlags().StringVar(&order, "order", "", "Specify ASC or DESC order")
	rootCmd.PersistentFlags().StringVar(&orderBy, "order-by", "", "Defines the column on which order is applied")
	rootCmd.PersistentFlags().StringSliceVar(&selects, "selects", nil, "prints only selected columns out of the whole table")
}


