module top_module (
    input clk,
    input in,
    output logic out
);

reg xor_output;
reg flip_flop_output;

always @(posedge clk)
    xor_output <= in ^ flip_flop_output;

always @(posedge clk)
    flip_flop_output <= xor_output;

always @(posedge clk)
    out <= flip_flop_output;

endmodule
