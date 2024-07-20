module top_module (
    input clk,
    input in,
    output reg out
);
    always @(posedge clk) begin
        if (clk) begin
            out <= in ^ out;
        end
    end
endmodule
