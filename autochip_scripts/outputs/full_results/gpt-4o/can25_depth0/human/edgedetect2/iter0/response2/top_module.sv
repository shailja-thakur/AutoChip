module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] anyedge);

    reg [7:0] in_d; // Delayed version of input

    always @(posedge clk) begin
        in_d <= in;       // Capture the input signal from the previous clock cycle
        anyedge <= in ^ in_d; // Detect any change (positive or negative edge)
    end
endmodule
