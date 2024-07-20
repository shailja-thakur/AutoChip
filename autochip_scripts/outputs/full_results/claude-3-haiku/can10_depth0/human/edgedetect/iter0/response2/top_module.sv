module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] pedge
);

reg [7:0] in_prev; // Register to store the previous input value

always @(posedge clk) begin
    in_prev <= in; // Store the current input value in the previous register
    pedge <= in & ~in_prev; // Detect the 0 to 1 transition and generate the output
end

endmodule
