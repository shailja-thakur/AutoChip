module top_module(
    input clk,
    input reset,
    input [31:0] in,
    output reg [31:0] out);

    reg [31:0] in_d;

    always @(posedge clk) begin
        if (reset) begin
            out <= 32'b0; // Reset output to 0
            in_d <= 32'b0; // Ensure in_d is also reset
        end else begin
            in_d <= in; // Capture the current input value
            out <= out | (in_d & ~in); // Capture 1-to-0 transitions
        end
    end
endmodule
