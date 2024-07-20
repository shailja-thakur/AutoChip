module top_module (
	input c,
	input d,
	output reg [3:0] mux_in
);

// Declare internal wires
reg ab_00, ab_01, ab_11, ab_10;

// Assign values to the internal wires
assign ab_00 = 1'b0;
assign ab_01 = 1'b1;
assign ab_11 = 1'b1;
assign ab_10 = 1'b1;

// Implement the logic for mux_in signals
always @(c, d) begin
	if (c == 0 && d == 0)
		mux_in[0] = ab_00;
	else if (c == 0 && d == 1)
		mux_in[1] = ab_00;
	else if (c == 1 && d == 0)
		mux_in[2] = ab_00;
	else if (c == 1 && d == 1)
		mux_in[3] = ab_00;
	else
		mux_in = 0; // default value
end

endmodule
