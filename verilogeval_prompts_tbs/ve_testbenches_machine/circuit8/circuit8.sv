//  This Verilog module has 2 inputs and 2 outputs. The inputs are a clock (clock) and a signal (a). The outputs are two registers, p and q. The clock signal is used to trigger the two always blocks. The first always block is triggered on the negative edge of the clock signal. This always block assigns the current value of the signal a to the register q. The second always block is triggered on any change of the input signal a. This always block assigns the current value of the signal a to the register p if the clock signal is high.




module top_module (
	input clock,
	input a, 
	output reg p,
	output reg q
);
