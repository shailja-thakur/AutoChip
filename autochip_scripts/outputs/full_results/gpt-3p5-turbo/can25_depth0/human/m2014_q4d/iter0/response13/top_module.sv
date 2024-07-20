module top_module (
    input clk,
    input in,
    output logic out
);

// Declare signals for D flip-flop
logic d_ff_input;
logic d_ff_output;

// Declare signals for XOR gate
logic xor_output;

// Connect D flip-flop input to XOR output
assign d_ff_input = xor_output;

// Instantiate D flip-flop
always_ff @(posedge clk)
    d_ff_output <= d_ff_input;

// Instantiate XOR gate
assign xor_output = in ^ d_ff_output;

// Output of the flip-flop
assign out = d_ff_output;

endmodule
