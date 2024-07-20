module top_module (
    input clk,
    input j,
    input k,
    output reg Q
);

always @(posedge clk) begin
    if (j & (~Q))
        Q <= j;
    else if (~k & Q)
        Q <= ~Q;
end

endmodule
