module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);
	reg [4:0] state, state_next;
	
	always @(posedge clk or negedge aresetn) begin
		if (!aresetn) begin
			state <= 5'bS;
		end else begin
			state <= state_next;
		end
	end
	
	always @(state or x) begin
		case(state)
			5'bS: begin
				if (x) begin
					state_next = 5'bS1;
				end else begin
					state_next = 5'bS;
				end
				z = 1'b0;
			end
			5'bS1: begin
				if (x) begin
					state_next = 5'bS;
				end else begin
					state_next = 5'bS10;
				end
				z = 1'b0;
			end
			5'bS10: begin
				if (x) begin
					state_next = 5'bS1;
				end else begin
					state_next = 5'bS10;
				end
				z = x;
			end
			default: begin
				state_next = 5'bS;
				z = 1'b0;
			end
		endcase
	end
	
endmodule
