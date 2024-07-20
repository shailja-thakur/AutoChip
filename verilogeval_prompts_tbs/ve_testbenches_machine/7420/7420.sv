//  This module is a simple logic gate that implements a 4-input AND gate with an inverted output. It has two sets of four inputs, p1a, p1b, p1c, and p1d, and p2a, p2b, p2c, and p2d. It also has two outputs, p1y and p2y. The p1y output is the result of the AND operation on the four inputs p1a, p1b, p1c, and p1d. The p2y output is the result of the AND operation on the four inputs p2a, p2b, p2c, and p2d. The outputs are inverted, so the output will be 0 if all the inputs are 1, and 1 if any of the inputs are 0.

module top_module(
	input p1a, 
	input p1b, 
	input p1c, 
	input p1d, 
	output p1y, 
	input p2a, 
	input p2b, 
	input p2c, 
	input p2d, 
	output p2y
);
