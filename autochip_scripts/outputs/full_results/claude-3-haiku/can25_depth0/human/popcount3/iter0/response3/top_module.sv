module top_module (
    input [2:0] in,
    output [1:0] out
);

always @(*) begin
    out = 0;
    if (in[0]) out = out + 1;
    if (in[1]) out = out + 1;
    if (in[2]) out = out + 1;
end

endmodule
