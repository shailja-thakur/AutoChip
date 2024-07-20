module top_module(
    input clk,
    input reset,
    input [31:0] in,
    output reg [31:0] out);

    reg [31:0] in_d;  // This will hold the delayed version of 'in'

    always @(posedge clk) begin
        if (reset) begin
            out <= 32'b0;
            in_d <= 32'b0;
        end else begin
            out <= out | (in_d & ~in);
            in_d <= in;
        end
    end

endmodule
