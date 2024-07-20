module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] anyedge);

    reg [7:0] prev_in;

    always @(posedge clk) begin
        prev_in <= in;
        anyedge <= (in ^ prev_in) & ~prev_in; // Detect 0 to 1 transitions, output is set in the cycle they occur
    end

endmodule
