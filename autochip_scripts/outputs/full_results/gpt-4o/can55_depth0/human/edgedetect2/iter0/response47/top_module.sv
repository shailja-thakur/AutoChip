module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] anyedge);

    reg [7:0] prev_in;

    // Detect edges and update anyedge output
    always @(posedge clk) begin
        anyedge <= in & ~prev_in; // Set output bit the cycle after a 0 to 1 transition
        prev_in <= in; // Update previous input
    end

endmodule
