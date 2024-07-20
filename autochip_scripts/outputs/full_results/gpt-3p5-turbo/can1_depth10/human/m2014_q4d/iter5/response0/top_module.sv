module top_module (
    input clk,
    input in,
    output logic out
);

reg xor_output;
reg flip_flop_output;

always @(posedge clk)
begin
    xor_output <= in ^ flip_flop_output;
    flip_flop_output <= xor_output;
    out <= flip_flop_output;
end

endmodule
