package cmd

import (
	"fmt"
	"reflect"
	"sort"
)

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
	rootCmd.PersistentFlags().StringVar(&order, "order", "ACS", "Specify ASC or DESC order")
	rootCmd.PersistentFlags().StringVar(&orderBy, "order-by", "", "Defines the column on which order is applied")
	rootCmd.PersistentFlags().StringSliceVar(&selects, "selects", nil, "prints only selected columns out of the whole table")
}

func GetOrderBy(slice interface{}, orderBy string, order string) error {

	sliceValue := reflect.ValueOf(slice)

	if sliceValue.Kind() != reflect.Slice {
		return fmt.Errorf("input is not a slice")
	}

	elementType := sliceValue.Type().Elem()

	if elementType.Kind() != reflect.Struct {
		return fmt.Errorf("elements are not structs")
	}

	field, found := elementType.FieldByName(orderBy)

	if !found {
		return fmt.Errorf("field '%s' not found in struct", orderBy)
	}

	fieldIndex := field.Index[0]
	if order == "ASC" {
		sort.Slice(slice, func(i, j int) bool {
			// Get the field values for the two elements
			valueI := sliceValue.Index(i).FieldByIndex([]int{fieldIndex}).Interface()
			valueJ := sliceValue.Index(j).FieldByIndex([]int{fieldIndex}).Interface()

			// Compare the field values
			return reflect.ValueOf(valueI).Interface().(int) < reflect.ValueOf(valueJ).Interface().(int)
		})
	} else if order == "DSC" {
		sort.Slice(slice, func(i, j int) bool {
			// Get the field values for the two elements
			valueI := sliceValue.Index(i).FieldByIndex([]int{fieldIndex}).Interface()
			valueJ := sliceValue.Index(j).FieldByIndex([]int{fieldIndex}).Interface()

			// Compare the field values
			return reflect.ValueOf(valueI).Interface().(int) > reflect.ValueOf(valueJ).Interface().(int)
		})
	}
	return nil
}

func ApplySkip(slice interface{}, skip int) (interface{}, error) {

	sliceValue := reflect.ValueOf(slice)
	if sliceValue.Kind() != reflect.Slice {
		return nil, fmt.Errorf("input is not a slice")
	}

	elemType := sliceValue.Type().Elem()
	if elemType.Kind() != reflect.Struct {
		return nil, fmt.Errorf("slice element is not a struct")
	}

	length := sliceValue.Len()
	if length < skip {
		return slice, nil
	}

	newSlice := reflect.MakeSlice(reflect.SliceOf(elemType), 0, 0)

	for i := skip; i < length; i++ {
		newSlice = reflect.Append(newSlice, sliceValue.Index(i))
	}

	return newSlice.Interface(), nil
}

func ApplyLimit(slice interface{}, limit int) (interface{}, error) {

	sliceValue := reflect.ValueOf(slice)
	if sliceValue.Kind() != reflect.Slice {
		return nil, fmt.Errorf("input is not a slice")
	}

	elemType := sliceValue.Type().Elem()
	if elemType.Kind() != reflect.Struct {
		return nil, fmt.Errorf("slice element is not a struct")
	}

	length := sliceValue.Len()
	if length < skip {
		return slice, nil
	}

	newSlice := reflect.MakeSlice(reflect.SliceOf(elemType), 0, 0)

	for i := 0; i < length; i++ {
		newSlice = reflect.Append(newSlice, sliceValue.Index(i))
	}

	return newSlice.Interface(), nil
}
