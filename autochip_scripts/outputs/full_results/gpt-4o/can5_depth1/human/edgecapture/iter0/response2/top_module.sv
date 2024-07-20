module top_module(
    input clk,
    input reset,
    input [31:0] in,
    output reg [31:0] out);

    reg [31:0] in_d;  // Register to hold the delayed version of the input

    always @(posedge clk) begin
        if (reset) begin
            out <= 32'b0;
        end
        else begin
            in_d <= in;  // Update the delayed input
            out <= out | (in_d & ~in);
        end
    end

endmodule
