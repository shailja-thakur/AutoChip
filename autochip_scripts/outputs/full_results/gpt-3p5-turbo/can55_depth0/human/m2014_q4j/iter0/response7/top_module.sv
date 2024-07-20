module top_module (
	input [3:0] x,
	input [3:0] y,
	output [4:0] sum
);
    wire [3:0] carry;
  
    // Full adder instances
    full_adder fa0(x[0], y[0], 1'b0, sum[0], carry[0]);
    full_adder fa1(x[1], y[1], carry[0], sum[1], carry[1]);
    full_adder fa2(x[2], y[2], carry[1], sum[2], carry[2]);
    full_adder fa3(x[3], y[3], carry[2], sum[3], sum[4]);
      
    // Full adder module definition
    module full_adder (
	    input a,
	    input b,
	    input cin,
	    output sum,
	    output cout
    );
        wire p, g;
        
        // Calculate sum and carry
        assign p = a ^ b;
        assign sum = p ^ cin;
        assign g = a & b;
        assign cout = g | (p & cin);
    endmodule
