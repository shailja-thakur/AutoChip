module top_module(
    input clk,
    input reset,
    input [31:0] in,
    output reg [31:0] out);

    reg [31:0] prev_in;
    reg [31:0] prev_out;

    always @(posedge clk or posedge reset) begin
        if (reset)
            prev_in <= 32'b0;
        else
            prev_in <= in;
    end

    always @(posedge clk) begin
        prev_out <= out;
        out <= prev_in & ~prev_out;
    end

endmodule
