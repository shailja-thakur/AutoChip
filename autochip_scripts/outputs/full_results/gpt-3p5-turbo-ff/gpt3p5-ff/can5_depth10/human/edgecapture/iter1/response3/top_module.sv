module top_module(
    input clk,
    input reset,
    input [31:0] in,
    output reg [31:0] out);

    reg [31:0] prev_in;
    reg [31:0] edge;

    always @(posedge clk or posedge reset) begin
        if (reset)
            prev_in <= 0;
        else
            prev_in <= in;

        edge <= prev_in & (~in | reset);

        if (reset)
            out <= 0;
        else
            out <= edge;
    end

endmodule
