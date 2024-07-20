module top_module (
    input clk,
    input in,
    output logic out
);

always @(posedge clk)
    out <= in ^ out;

endmodule
