module top_module(
    input clk,
    input reset,
    input [31:0] in,
    output reg [31:0] out);

    reg [31:0] prev_in;

    always @(posedge clk) begin
        if (reset)
            out <= 32'b0;
        else begin
            out <= out | (prev_in & ~in);
            prev_in <= in;
        end
    end
endmodule
