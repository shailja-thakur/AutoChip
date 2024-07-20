module top_module(
    input clk,
    input reset,
    input [31:0] in,
    output reg [31:0] out);
    
    reg [31:0] in_d; // Register to hold the previous state of the input
    
    always @(posedge clk) begin
        if (reset) begin
            out <= 32'b0;
        end else begin
            // Capture where the input changes from 1 to 0
            out <= out | (in_d & ~in);
        end
        in_d <= in; // Update the previous state register
    end
endmodule
