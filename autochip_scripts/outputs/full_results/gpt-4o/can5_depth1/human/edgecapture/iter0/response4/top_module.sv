module top_module(
    input clk,
    input reset,
    input [31:0] in,
    output reg [31:0] out);

    reg [31:0] in_d; // Register to store delayed input value

    always @(posedge clk) begin
        if (reset) begin
            out <= 32'b0;
            in_d <= 32'b0;
        end else begin
            // Capture the change from 1 to 0
            out <= out | (in_d & ~in);
            // Update the delayed input
            in_d <= in;
        end
    end
endmodule
