module top_module (
	input a, 
	input b,
	input c,
	input d,
	output out
);

wire [1:0] ab;
wire [1:0] cd;

assign ab = {a, b};
assign cd = {c, d};

// Karnaugh Map Logic
assign out = (ab == 2'b00) ? 1'b1 :
             (ab == 2'b01) ? 1'b0 :
             (ab == 2'b11) ? 1'b1 :
             (ab == 2'b10) ? 1'b0 :
             1'b0;

endmodule
