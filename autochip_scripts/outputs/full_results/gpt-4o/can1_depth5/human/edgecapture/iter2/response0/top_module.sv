module top_module(
    input clk,
    input reset,
    input [31:0] in,
    output reg [31:0] out);

    // Register to hold the previous state of input
    reg [31:0] prev_in;

    always @(posedge clk) begin
        if (reset) begin
            out <= 32'b0; // Reset output to 0
            prev_in <= 32'b0; // Reset the previous input register to 0
        end else begin
            // Capture changes from 1 to 0
            out <= out | (prev_in & ~in);
            prev_in <= in; // Update previous input
        end
    end
endmodule
