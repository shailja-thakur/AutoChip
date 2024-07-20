module top_module (
	input clk,
	input in,
	output logic out
);

// Declare Flip-flop outputs
reg d_ff_out;

// Create XOR gate
assign out = in ^ d_ff_out;

// D flip-flop (positive edge-triggered)
always @(posedge clk) begin
    d_ff_out <= in;
end

endmodule
