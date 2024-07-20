module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] pedge
);

reg [7:0] in_d; // Register to store the previous input value

always @(posedge clk) begin
    in_d <= in; // Store the current input value in the previous input register
    pedge <= in & ~in_d; // Calculate the positive edge detection by ANDing the current input with the negated previous input
end

endmodule
