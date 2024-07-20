module top_module (
    input clk,
    input j,
    input k,
    output reg Q
);

always @(posedge clk) begin
    if (j == 1'b1 && k == 1'b0)
        Q <= j;
    else if (j == 1'b0 && k == 1'b1)
        Q <= 1'b0;
    else if (j == 1'b1 && k == 1'b1)
        Q <= ~Q;
end

endmodule
