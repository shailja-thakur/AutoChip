module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] pedge
);

reg [7:0] in_prev; // Store the previous input value

always @(posedge clk) begin
    in_prev <= in; // Store the current input value in the previous register
    pedge <= in & ~in_prev; // Set the output bits where the current input bit is 1 and the previous input bit was 0
end

endmodule
