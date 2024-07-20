module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] anyedge
);

    reg [7:0] prev_in;

    always @(posedge clk) begin
        prev_in <= in;          // Store the previous cycle's input
        anyedge <= (in & ~prev_in); // Detect 0 to 1 transitions
    end

endmodule
