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
        out <= (in & ~{32{out[31:0]}}) | (out & {32{in[31:0]}});
    end
end

endmodule
