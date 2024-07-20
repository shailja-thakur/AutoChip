module top_module (
	input a,
	input b,
	input c,
	input d,
	output out_sop,
	output out_pos
);

// Define the output signals
reg out_sop;
reg out_pos;

// Define the internal wire signals
wire [1:0] inputs;

// Assign the input signals to the internal wire signals
assign inputs = {a, b, c, d};

// Determine the output out_sop in minimum sum-of-products form
always @(inputs) begin
	case (inputs)
		2'b10: out_sop = 1;
		2'b1111: out_sop = 1;
		default: out_sop = 0;
	endcase
end

// Determine the output out_pos in minimum product-of-sums form
always @(inputs) begin
	case (inputs)
		2'b00: out_pos = 0;
		2'b01: out_pos = 0;
		2'b100: out_pos = 0;
		2'b101: out_pos = 0;
		2'b110: out_pos = 0;
		2'b1001: out_pos = 0;
		2'b1010: out_pos = 0;
		2'b1101: out_pos = 0;
		2'b1110: out_pos = 0;
		default: out_pos = 1;
	endcase
end

endmodule
