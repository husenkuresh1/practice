package models

type Trains []Train

type Train struct {
	Id string
	// ....
}


type TrainModel struct {
}

func LoadDataFromCSV(filePath string) ([]Train, error) {
	return nil, nil
}

func(t TrainModel) ListAndPrint(train []Train) {
	
}


func Main() {
	trains, err := LoadDataFromCSV()
	if err != nil {
		// ...
	}
	tm := TrainModel{}
	tm.ListAndPrint(trains)
}

