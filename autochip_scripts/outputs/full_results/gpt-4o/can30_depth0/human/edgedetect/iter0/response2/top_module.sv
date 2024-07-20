module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] pedge);

    reg [7:0] in_d; // Register to store the previous state of the input

    always @(posedge clk) begin
        in_d <= in;
        pedge <= ~in_d & in; // Detecting rising edge (0 to 1 transition)
    end
endmodule
