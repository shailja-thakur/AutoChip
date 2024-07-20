module top_module(
    input clk,
    input reset,
    input [31:0] in,
    output reg [31:0] out);

    reg [31:0] d_last;

    always @(posedge clk or posedge reset) begin
        if (reset)
            d_last <= 0;
        else if (clk) begin
            out <= out | (~in & d_last);
            d_last <= in;
        end
    end

endmodule
