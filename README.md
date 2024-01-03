# ✨ Bookit (CRUV Assignment)

##  Brief Description

* This is the demonstration of app Assignment similar to train booking app with seat layout to search for seats with additional featrues and optimisations.


##  Features

* Auto Scrolling on Search to the searched seat number.
* Use of ListView.builder for optimising scrolling and render of seat layout   widgets on screen.
* Providing seat Reservation info on tapping a particular seat . Based on data from Chart.json local file.
* Making Responsive ui design and layouts by using MediaQuesries to get a correct measures of spaces and padding based on device height and width.

##  Getting Started

### Prerequisites

* Flutter SDK
* Android Studio
### Running Locally

To deploy this project run

```bash
  git clone https://github.com/AayushAnand07/CRUV.git
```

```bash
  cd CRUV
  flutter run
```


## Demo

### Auto Scrolling Feature
https://github.com/AayushAnand07/CRUV/assets/41218074/11154824-23ce-4d7b-8a42-7fd498bc34e9


### Seat Reservation Status
https://github.com/AayushAnand07/CRUV/assets/41218074/20d498df-371a-443f-a477-75376f214bf2


### Full App Demo
https://github.com/AayushAnand07/CRUV/assets/41218074/fb2192cf-5af4-401c-83f1-2475959e7206

## Chart.Json Structure

```bash
{
  "seats": [
    {
      "seatNo": 12,
            "reservations": [
                {
                    "from": "New Delhi",
                    "to": "Agra"
                },
                {
                    "from": "Kanpur",
                    "to": "Patna"
                }
            ]
    },

   ]

}
```
