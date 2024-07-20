module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] pedge
);

reg [7:0] in_d; // Register to store the previous input value

always @(posedge clk) begin
    in_d <= in; // Store the current input value in the previous value register
    pedge <= in & ~in_d; // Detect the 0 to 1 transition and generate the pedge output
end

endmodule
