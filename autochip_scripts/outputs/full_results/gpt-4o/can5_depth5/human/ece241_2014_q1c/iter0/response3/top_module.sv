module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);
    
    wire [8:0] extended_a, extended_b, extended_s;
    
    assign extended_a = {a[7], a};
    assign extended_b = {b[7], b};
    assign extended_s = extended_a + extended_b;
    
    assign s = extended_s[7:0];
    assign overflow = (extended_a[8] == extended_b[8]) && (extended_a[8] != extended_s[8]);

endmodule
