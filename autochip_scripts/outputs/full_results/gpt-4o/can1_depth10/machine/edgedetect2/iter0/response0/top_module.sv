module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] anyedge);

    reg [7:0] d_last; // Register to store the previous value of the 'in' signal

    always @(posedge clk) begin
        d_last <= in; // Update the previous value with the current value
        anyedge <= in ^ d_last; // Perform XOR to detect edge changes
    end
endmodule
