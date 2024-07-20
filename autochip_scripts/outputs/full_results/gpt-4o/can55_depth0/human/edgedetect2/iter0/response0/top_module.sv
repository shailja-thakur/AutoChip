module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] anyedge
);

    // Register to hold the previous state of inputs
    reg [7:0] prev_in;
    
    always @(posedge clk) begin
        // Detect any edge by comparing the current input with the previous input
        anyedge <= in & ~prev_in;
        // Update the previous input to the current input
        prev_in <= in;
    end

endmodule
