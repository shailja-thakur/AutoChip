module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] anyedge);

    reg [7:0] prev_in;

    always @(posedge clk) begin
        prev_in <= in;
        anyedge <= (in & ~prev_in); // results in '1' if there's a 0 -> 1 transition
    end

endmodule
