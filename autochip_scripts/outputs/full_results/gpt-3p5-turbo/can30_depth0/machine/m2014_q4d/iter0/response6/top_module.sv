module top_module (
    input clk,
    input in,
    output out
);

reg out;

always @(posedge clk) begin
    out <= in ^ out;
end

endmodule
