module top_module(
	input x,
	input y,
	output z);
	
	wire a;
	wire b;
	
	and_gate and1(x, y, a);
	and_gate and2(y, x, b);
	and_gate and3(a, b, z);
	
endmodule
module and_gate(
    input a,
    input b,
    output z);
    
	assign z = a & b;
    
endmodule
