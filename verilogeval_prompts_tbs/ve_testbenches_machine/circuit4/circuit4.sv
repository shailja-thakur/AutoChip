//  This top module is a simple logic gate that takes four inputs (a, b, c, and d) and produces one output (q). The output q is the result of a logical OR operation between the inputs b and c. This means that the output q will be high if either input b or input c is high, and it will be low if both inputs b and c are low. The inputs a and d are not used in this module.

module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);
