module top_module(
    input clk,
    input reset,
    input [31:0] in,
    output reg [31:0] out);

    reg [31:0] in_d; // delayed version of the input

    always @(posedge clk) begin
        if (reset) begin
            out <= 32'b0;
            in_d <= 32'b0;
        end else begin
            in_d <= in;
            out <= out | (in_d & ~in);
        end
    end
endmodule
