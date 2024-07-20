module top_module (
    input clk,
    input in,
    output logic out
);

logic xor_output;
logic flip_flop_output;

// Implement XOR gate
assign xor_output = in ^ flip_flop_output;

// Implement the D flip-flop
always_ff @(posedge clk)
    flip_flop_output <= xor_output;

// Assign the flip-flop output to the 'out' output
assign out = flip_flop_output;

endmodule
