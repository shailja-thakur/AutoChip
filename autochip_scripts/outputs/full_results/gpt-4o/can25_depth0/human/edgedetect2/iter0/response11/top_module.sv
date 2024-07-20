module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] anyedge);

    reg [7:0] prev_in;

    always @(posedge clk) begin
        anyedge <= (in & ~prev_in); // Detect rising edges
        prev_in <= in; // Store the current state for the next clock cycle
    end
endmodule
