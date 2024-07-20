module top_module(
	input clk,
	input reset,
	input data,
	output reg start_shifting);

	reg [3:0] state;
	reg [3:0] next_state; 

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 0;
			start_shifting <= 0;
		end else begin
			state <= next_state; 
		end
	end

	wire [3:0] shifted_state;
	assign shifted_state = (state << 1) | data;

	always @(shifted_state or reset) begin
		case (shifted_state)
			4'd6: start_shifting <= 1; // 1101
			default: start_shifting <= 0;
		endcase
	end

endmodule
