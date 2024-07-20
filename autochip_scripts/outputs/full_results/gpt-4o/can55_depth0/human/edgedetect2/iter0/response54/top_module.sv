module top_module(
	input clk,
	input [7:0] in,
	output reg [7:0] anyedge);

    reg [7:0] prev_in;
    
    always @(posedge clk) begin
        // Detect the transitions by comparing current and previous inputs
        anyedge <= (prev_in ^ in) & in;
        // Store the current input for the next clock cycle
        prev_in <= in;
    end
endmodule
