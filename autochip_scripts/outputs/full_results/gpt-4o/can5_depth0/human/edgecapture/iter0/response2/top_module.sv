module top_module(
    input clk,
    input reset,
    input [31:0] in,
    output reg [31:0] out);

    reg [31:0] prev_in;

    // Sequential process
    always @(posedge clk) begin
        if (reset) begin
            out <= 32'b0;      // Reset output to 0
            prev_in <= 32'b0;  // Reset previous input to 0
        end else begin
            out <= out | (prev_in & (~in));  // Capture the change from 1 to 0
            prev_in <= in;                   // Update previous input
        end
    end
endmodule
