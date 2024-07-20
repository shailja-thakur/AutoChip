module top_module (
	input [3:0] a, 
	input [3:0] b, 
	input [3:0] c, 
	input [3:0] d,
	input [3:0] e,
	output reg [3:0] q
);
// always block to continuously evaluate the value of input c
always @(c) begin
    case (c)
        2'b00: q <= b; // if c is 0, assign q the value of b
        2'b01: q <= e; // if c is 1, assign q the value of e
        2'b10: q <= a; // if c is 2, assign q the value of a
        2'b11: q <= d; // if c is 3, assign q the value of d
        default: q <= 4'hf; // for any other value of c, assign q the value of 4'hf
    endcase
end

endmodule
