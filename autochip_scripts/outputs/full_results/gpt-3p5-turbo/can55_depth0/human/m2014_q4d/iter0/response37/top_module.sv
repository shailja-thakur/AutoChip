module top_module (
	input clk,
	input in,
	output logic out
);

logic xor_output;
logic d_input;

// XOR gate
assign xor_output = in ^ out;

// D flip-flop
always @(posedge clk) begin
    out <= d_input;
    d_input <= xor_output;
end

endmodule
