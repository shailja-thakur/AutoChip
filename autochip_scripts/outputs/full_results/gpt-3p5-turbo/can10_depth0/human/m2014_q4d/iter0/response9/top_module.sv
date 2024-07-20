module top_module (
    input clk,
    input in,
    output logic out
);

reg D;
always @(posedge clk)
    D <= in ^ out;

always @(posedge clk)
    out <= D;

endmodule
