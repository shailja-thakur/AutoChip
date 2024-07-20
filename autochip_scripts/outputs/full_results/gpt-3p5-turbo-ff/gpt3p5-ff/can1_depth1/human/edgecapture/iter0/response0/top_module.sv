module top_module(
    input clk,
    input reset,
    input [31:0] in,
    output reg [31:0] out);

    reg [31:0] prev_in;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            prev_in <= 0;
            out <= 0;
        end else begin
            prev_in <= in;
            out <= (prev_in & ~in);
        end
    end

endmodule
