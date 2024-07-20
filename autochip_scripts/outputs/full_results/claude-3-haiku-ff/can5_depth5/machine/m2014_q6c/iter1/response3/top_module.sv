module top_module (
    input [6:0] y,
    input w,
    output reg Y2,
    output reg Y4
);

always @(*) begin
    Y2 = y[0] & ~w;
    Y4 = y[1] & y[2] & y[4] & y[5] & w;
end

endmodule
