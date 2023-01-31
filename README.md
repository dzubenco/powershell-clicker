# powershell-clicker

## Configuration

[click.ps1](./click.ps1) file has several variables at the very top which can be adjusted to configure this clicker properly.

* `$InitialDelayMs` - represents how much time will pass between clicker run and first click (in milliseconds)

* `$IntervalMs` - delay in milliseconds between each click

* `$RightClick` - boolean variable; set it to `true` is case if you want clicker to perform Right Mouse Button clicks

* `$NoMove` - boolean variable; set it to `true` in case if you want script to click at the same point which cursor is currently set to

* `$x1, $x2, $y1, $y2` - coordinates of a rectangular area (please refer to the schema below). Script will perform click on a random position inside of this area; note: `$NoMove` should be set to `false` so that this option can work

![Img1](https://user-images.githubusercontent.com/74211642/215801754-2c403dd5-62ed-4525-86e2-86b678d974e0.PNG)


## How to Run

* Clone this repo to your local machine 

```git clone https://github.com/dzubenco/powershell-clicker.git```

* Open WIndows PowerShell, move to the cloned directory

* Run the script using below command

```./click.ps1```

* To stop the script, just exis script execution by pressing `Ctrl+C`


