module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);
	parameter S = 2'b00;
	parameter S1 = 2'b01;
	parameter S10 = 2'b10;
	
	reg [1:0] state;
	
	always @(posedge clk or negedge aresetn) begin
		if (~aresetn) begin
			state <= S;
		end else begin
			case ({x, state})
				2'b0S: state <= S;
				2'b1S: state <= S1;
				2'b0S1: state <= S10;
				2'b1S1: state <= S1;
				2'b0S10: state <= S;
				2'b1S10: state <= S1;
			endcase
		end
	end
	
	always @(state) begin
		case (state)
			S: z <= 1'b0;
			S1: z <= 1'b0;
			S10: z <= x;
		endcase
	end
endmodule
