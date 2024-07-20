module top_module(
    input clk,
    input reset,
    input [31:0] in,
    output reg [31:0] out);

    always @(posedge clk or posedge reset) begin
        if (reset)
            out <= 0;
        else if (clk) begin
            out <= in | (~in & out);
        end
    end

endmodule
