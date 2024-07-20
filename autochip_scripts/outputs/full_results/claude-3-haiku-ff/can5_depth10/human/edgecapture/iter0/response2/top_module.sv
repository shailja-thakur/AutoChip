module top_module(
    input clk,
    input reset,
    input [31:0] in,
    output reg [31:0] out
);

always @(posedge clk) begin
    if (reset) begin
        out <= 0;
    end
    else begin
        out <= (in ^ out) & in;
    end
end

endmodule
