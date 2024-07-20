module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);
	reg [3:0] state, next_state;
	
	always @(posedge clk or negedge aresetn) begin
		if (!aresetn) begin
			state <= 4'b0000; // initialize state
		end
		else begin
			state <= next_state;
		end
	end
	
	always @(state or x) begin
		case (state)
			4'b0000: begin // S
				if (x == 1'b0)
					next_state = 4'b0000; // S
				else if (x == 1'b1)
					next_state = 4'b0001; // S1
			end
			4'b0001: begin // S1
				if (x == 1'b0)
					next_state = 4'b0010; // S10
				else if (x == 1'b1)
					next_state = 4'b0001; // S1
			end
			4'b0010: begin // S10
				if (x == 1'b0)
					next_state = 4'b0000; // S
				else if (x == 1'b1)
					next_state = 4'b0001; // S1
			end
			default: begin
				next_state = 4'b0000; // S
			end
		endcase
	end
	
	always @(state) begin
		case (state)
			4'b0000: z = 1'b0; // S
			4'b0001: z = 1'b0; // S1
			4'b0010: z = x; // S10
			default: z = 1'b0; // default to 0
		endcase
	end
endmodule
