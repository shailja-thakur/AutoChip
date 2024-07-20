module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] anyedge);

    reg [7:0] prev_in;

    always @(posedge clk) begin
        anyedge <= (prev_in & ~in) | (~prev_in & in); // Detect any edge (0 to 1 or 1 to 0)
        prev_in <= in;
    end

endmodule
