# JuFPGA
This is a repository based on my own tinkering with an FPGA board.

## Binary Arithmatic with IO Shield
This is a basic example of using the IO shield with binary representations of numbers to dispay addition, subtraction and multiplication. 

<p float="center">
<img src="https://github.com/JamesUnicomb/JuFPGA/blob/master/docs/in_out_test/lucid_screenshot.png" width="480" />
</p>

A simple demo showing the operation is below:

[![](https://img.youtube.com/vi/BpOkozvImDQ/0.jpg)](https://www.youtube.com/watch?v=BpOkozvImDQ)

## LED Clock Counter

[![](https://img.youtube.com/vi/ta-bTDBFUSI/0.jpg)](https://www.youtube.com/watch?v=ta-bTDBFUSI)


## Stopwatch

[![](https://img.youtube.com/vi/0JB5V0f_EV8/0.jpg)](https://www.youtube.com/watch?v=0JB5V0f_EV8)

## Analog Read

Read an analog signal with the XADC module. Depending on the analog signal a PWM pulse is changed to adjust the brightness of the onboard LEDs.

### Infra-Red Distance Sensor

This takes in a signal from an IR distance sensor.

[![](https://img.youtube.com/vi/yXhs7y5ThxE/0.jpg)](https://www.youtube.com/watch?v=yXhs7y5ThxE)


### Potentiometer

This takes in a signal from a potentiometer. 

[![](https://img.youtube.com/vi/EgQyOCMgAjs/0.jpg)](https://www.youtube.com/watch?v=EgQyOCMgAjs)


### Controlling an RGB LED from Analog Input

From the analog signals, we control the output of the pins connected to an RGB LED to change the colour of the light. 

[![](https://img.youtube.com/vi/g2sVJFCQYy0/0.jpg)](https://www.youtube.com/watch?v=g2sVJFCQYy0)

[![](https://img.youtube.com/vi/MgEa42TiXPE/0.jpg)](https://www.youtube.com/watch?v=MgEa42TiXPE)


# Mimas A7

## Flashing the Mimas A7 with OpenOCD

```
sudo openocd -f numato_mimasa7.cfg -c "init" -c "pld load 0 ../vivado/mimasa7_hdmi_out/mimasa7_hdmi_out.runs/impl_1/dvid_test.bit" -c "shutdown"
```

## HDMI Output with Mandelbrot LUT

As a basic demo, we can precompute the mandelbrot set and store it in the FPGA as a LUT. 

<p align="center">
  <img src="https://github.com/JamesUnicomb/JuFPGA/blob/master/mandelbrot_HDMI_LUT/mandelbrot_lut_hdmi.JPG" width="480" title="hover text" width="350">
</p>


## HDMI Output with Screen Brightness Control from IR Sensor

[![](https://img.youtube.com/vi/0eKhvgNOn18/0.jpg)](https://www.youtube.com/watch?v=0eKhvgNOn18)

## HDMI Output displaing Mandelbrot set Control from IR Sensor

<p align="center"><img src="https://latex.codecogs.com/gif.latex?\begin{align*}&space;z_0&space;&&space;=&space;0&space;\\&space;z_{n&plus;1}&space;&=&space;z_n^d&space;&plus;&space;c&space;\end{align*}" title="\begin{align*} z_0 & = 0 \\ z_{n+1} &= z_n^d + c \end{align*}" /></p>

[![](https://img.youtube.com/vi/_Eo6dRAJnyw/0.jpg)](https://www.youtube.com/watch?v=_Eo6dRAJnyw)






