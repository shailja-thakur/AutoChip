module top_module (
    input wire clk,
    input wire in,
    output reg out
);

initial begin
    out = 0;
end

always @(posedge clk) begin
    out <= in ^ out;
end

endmodule
