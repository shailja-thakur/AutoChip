module top_module(
    input clk,
    input reset,
    input [31:0] in,
    output reg [31:0] out);

    reg [31:0] reg_out;

    always @(posedge clk or posedge reset) begin
        if (reset)
            reg_out <= 0;
        else begin
            reg_out <= in;
            out <= reg_out & ~in;
        end
    end

endmodule
