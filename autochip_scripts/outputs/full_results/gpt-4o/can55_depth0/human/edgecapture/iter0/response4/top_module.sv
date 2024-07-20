module top_module(
    input clk,
    input reset,
    input [31:0] in,
    output reg [31:0] out);
    
    // Declare internal 32-bit register to store previous state of 'in'
    reg [31:0] prev_in;
    
    always @(posedge clk) begin
        if (reset) begin
            // Reset output and previous input registers
            out <= 32'b0;
            prev_in <= 32'b0;
        end else begin
            // Capture the falling edge from 1 to 0
            out <= out | (prev_in & ~in);
            // Update previous input register for next clock cycle
            prev_in <= in;
        end
    end
endmodule
