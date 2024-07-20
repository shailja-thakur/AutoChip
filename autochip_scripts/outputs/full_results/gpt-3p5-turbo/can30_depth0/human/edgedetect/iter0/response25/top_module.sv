module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] pedge);

always @(posedge clk) begin
    pedge <= pedge & ~in;  // Check for transitions from 0 to 1
end

endmodule
