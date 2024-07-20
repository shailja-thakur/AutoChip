module top_module(
    input clk,
    input reset,
    input [31:0] in,
    output reg [31:0] out);

    reg [31:0] in_reg;

    always @(posedge clk or posedge reset) begin
        if (reset)
            in_reg <= 32'b0;
        else
            in_reg <= in;
    end

    always @(posedge clk or posedge reset) begin
        if (reset)
            out <= 32'b0;
        else
            out <= in_reg & ~in;
    end

endmodule
