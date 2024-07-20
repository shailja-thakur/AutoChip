module top_module(
    input clk,
    input reset,
    input [31:0] in,
    output reg [31:0] out);

    reg [31:0] prev_in;
    reg [31:0] is_changed;

    always @(posedge clk or posedge reset) begin
        if (reset)
            prev_in <= 0;
        else
            prev_in <= in;
    end

    always @(posedge clk) begin
        is_changed <= (prev_in & ~in);
        out <= out | is_changed;
    end

endmodule
