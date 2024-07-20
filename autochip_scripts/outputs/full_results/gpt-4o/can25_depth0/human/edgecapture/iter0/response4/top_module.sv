module top_module(
    input clk,
    input reset,
    input [31:0] in,
    output reg [31:0] out);

    reg [31:0] in_d; // Register to hold the delayed value of input

    always @(posedge clk) begin
        if (reset) begin
            out <= 32'd0; // Reset the output to 0
            in_d <= 32'd0; // Reset the delayed input to 0
        end else begin
            in_d <= in; // Capture the current value of input
            out <= out | (in_d & ~in); // Capture the falling edge
        end
    end
endmodule
