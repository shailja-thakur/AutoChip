module top_module(
    input clk,
    input reset,
    input [31:0] in,
    output reg [31:0] out);

    reg [31:0] previous_in;

    always @(posedge clk or posedge reset) begin
        if (reset)
            previous_in <= 32'b0;
        else
            previous_in <= in;
    end

    always @(posedge clk) begin
        out <= (previous_in & ~in) | (out & in);
    end

endmodule
