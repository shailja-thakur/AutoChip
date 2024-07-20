module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] pedge);

    reg [7:0] in_d; // Register to store the delayed version of 'in'

    always @(posedge clk) begin
        in_d <= in; // Capture the input signal on the rising edge of the clock
        pedge <= (~in_d & in); // Positive edge detection
    end

endmodule
