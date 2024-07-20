module top_module(
	input clk,
	input [7:0] in,
	output reg [7:0] anyedge);

    reg [7:0] prev_in; // Register to hold the previous value of 'in'

    always @(posedge clk) begin
        // Compare each bit of 'in' with corresponding bit in 'prev_in'
        anyedge <= (prev_in ^ in) & in;
        
        // Store current 'in' value for next cycle comparison
        prev_in <= in;
    end
endmodule
