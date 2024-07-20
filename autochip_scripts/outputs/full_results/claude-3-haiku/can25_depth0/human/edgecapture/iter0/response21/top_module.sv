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
        out <= (in & ~{in[30:0], 1'b0}) | (out & ~reset);
    end
end

endmodule
