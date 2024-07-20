module top_module (
	input clk,
	input reset,
	input in,
	output reg disc,
	output reg flag,
	output reg err);

	reg [3:0] state, next_state;
	
	// State encoding
	localparam S0 = 4'd0,
	           S1 = 4'd1,
	           S2 = 4'd2,
	           S3 = 4'd3,
	           S4 = 4'd4,
	           S5 = 4'd5,
	           S6 = 4'd6,
	           S7 = 4'd7,
	           S8 = 4'd8,
	           ERR = 4'd9;
	
	// State transition
	always @(*) begin
		case(state)
			S0    : next_state = in ? S1 : S0;
			S1    : next_state = in ? S2 : S0;
			S2    : next_state = in ? S3 : S0;
			S3    : next_state = in ? S4 : S0;
			S4    : next_state = in ? S5 : S0;
			S5    : next_state = in ? S6 : S0;
			S6    : next_state = in ? S7 : S0;
			S7    : next_state = in ? ERR : S8;
			S8    : next_state = in ? S1 : S0;
			ERR   : next_state = in ? ERR : S0;
			default: next_state = S0;
		endcase
	end
	
	// State registers
	always @(posedge clk) begin
		if (reset)
			state <= S0;
		else
			state <= next_state;
	end
	
	// Output logic
	always @(posedge clk) begin
		if (reset) begin
			disc <= 1'b0;
			flag <= 1'b0;
			err <= 1'b0;
		end
		else begin
			disc <= 1'b0;
			flag <= 1'b0;
			err <= 1'b0;
			case (state)
				S6: if (~in) disc <= 1'b1; // "0111110" sequence
				S8: flag <= 1'b1;         // "01111110" sequence
				ERR: err <= 1'b1;         // "01111111..." sequence
			endcase
		end
	end
	
endmodule
