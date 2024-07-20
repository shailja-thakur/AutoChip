module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

	reg [3:0] state, next_state;

	// State definitions
	localparam S = 4'b0000;
	localparam S1 = 4'b0001;
	localparam S10 = 4'b0010;

	always @(posedge clk or negedge aresetn) begin
		if (!aresetn) begin
			state <= S; //initial state
		end else begin
			state <= next_state;
		end
	end
	
	always @(state or x) begin
		case(state)
			S: begin
				if (x == 1'b0) begin
					next_state = S;
				end else if (x == 1'b1) begin
					next_state = S1;
				end
			end
			S1: begin
				if (x == 1'b0) begin
					next_state = S10;
				end else if (x == 1'b1) begin
					next_state = S1;
				end
			end
			S10: begin
				if (x == 1'b0) begin
					next_state = S;
				end else if (x == 1'b1) begin
					next_state = S1;
				end
			end
			default: next_state = S; //default case
		endcase
	end
	
	always @(state) begin
		case(state)
			S, S1: z = 1'b0;
			S10: z = x;
			default: z = 1'b0; //default case
		endcase
	end
	
endmodule
