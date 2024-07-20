module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] anyedge);

    // Register to hold the input value from the previous clock cycle
    reg [7:0] prev_in;

    always @(posedge clk) begin
        // Compare current input with previous input to detect edges
        anyedge <= (in & ~prev_in); // Detect 0 to 1 transitions
        // Update prev_in with current input for the next cycle
        prev_in <= in;
    end
endmodule
