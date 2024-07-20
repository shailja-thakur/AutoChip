module flipflop(
    input clk,
    input D,
    output reg Q
);

always @(posedge clk) begin
    Q <= D;
end

endmodule
module mux_2to1(
    input S,
    input D0,
    input D1,
    output reg Y
);

always @(S, D0, D1) begin
    if (S == 0)
        Y <= D0;
    else
        Y <= D1;
end

endmodule
