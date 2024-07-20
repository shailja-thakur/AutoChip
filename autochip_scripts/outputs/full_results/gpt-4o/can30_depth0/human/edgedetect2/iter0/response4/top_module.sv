module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] anyedge);

    reg [7:0] prev_in;

    always @(posedge clk) begin
        prev_in <= in; // Store the previous state of the input
    end

    always @(posedge clk) begin
        anyedge <= (prev_in ^ in) & in; // Detect any edge and set output bit on 0 to 1 transition
    end

endmodule
