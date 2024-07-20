module top_module (
    input clk,
    input a,
    input b,
    output q,
    output state
);

reg flip_flop;

always @(posedge clk) begin
    if (a & !b)
        flip_flop <= 0;
    else if (!a & b)
        flip_flop <= 1;
end

assign q = flip_flop;
assign state = flip_flop;

endmodule
