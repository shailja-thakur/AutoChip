module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);
    // internal wire to hold the overflow value
    wire overflow_value;
    
    // internal wire to hold the carryout of the MSB addition
    wire carryout;
    
    // wire a, b, s, and overflow to internal signals
    assign s = a + b;
    assign carryout = a[7] + b[7];
    assign overflow_value = (a[7] & b[7] & ~s[7]) | (~a[7] & ~b[7] & s[7]);

    // assign overflow based on overflow_value
    assign overflow = overflow_value;
endmodule
