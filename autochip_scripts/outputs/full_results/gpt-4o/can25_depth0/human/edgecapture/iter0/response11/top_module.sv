module top_module(
    input clk,
    input reset,
    input [31:0] in,
    output reg [31:0] out);

    reg [31:0] in_d; // Register to hold the delayed version of input 'in'

    always @(posedge clk) begin
        if (reset) begin
            out <= 32'b0;  // Reset output to all zeros
            in_d <= 32'b0; // Reset the delayed input register
        end else begin
            in_d <= in;   // Capture the current input for comparison in the next clock cycle

            // Check for transitions from 1 to 0
            out <= out | (in_d & ~in);
        end
    end

endmodule
