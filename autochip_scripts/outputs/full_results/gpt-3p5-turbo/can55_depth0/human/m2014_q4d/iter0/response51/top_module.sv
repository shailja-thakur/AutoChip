module top_module (
    input clk,
    input in,
    output logic out
);

logic xor_out;
logic flip_flop_out;

// XOR gate
assign xor_out = in ^ flip_flop_out;

// D flip-flop
always_ff @(posedge clk)
    flip_flop_out <= xor_out;

assign out = flip_flop_out;

endmodule
