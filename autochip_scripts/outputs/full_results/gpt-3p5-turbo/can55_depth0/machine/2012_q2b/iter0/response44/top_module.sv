module top_module (
    input [5:0] y,
    input w,
    output reg Y1,
    output reg Y3
);

always @(*) begin
    Y1 = y[0] & w;
    Y3 = (y[1] | y[2] | y[4] | y[5]) & ~w;
end

endmodule
