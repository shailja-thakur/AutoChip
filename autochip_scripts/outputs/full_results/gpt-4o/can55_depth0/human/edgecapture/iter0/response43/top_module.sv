module top_module(
    input clk,
    input reset,
    input [31:0] in,
    output reg [31:0] out);

    reg [31:0] in_d;  // Register to hold the delayed input

    always @(posedge clk) begin
        if (reset) begin
            out <= 32'b0;     // Synchronous reset
        end else begin
            in_d <= in;       // Update the delayed input at each clock cycle
            out <= out | (in_d & ~in); // Capture falling edge
        end
    end
endmodule
