module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);
	reg [3:0] state, state_next;
	always @(posedge clk or negedge aresetn) begin
		if (!aresetn) begin
			state <= 4'bS;
		end else begin
			state <= state_next;
		end
	end
	
	always @(*) begin
		case (state)
			4'bS: begin
				if (x == 1'b0)
					state_next = 4'bS;
				else
					state_next = 4'bS1;
				z = 1'b0;
			end
			4'bS1: begin
				if (x == 1'b0)
					state_next = 4'bS10;
				else
					state_next = 4'bS1;
				z = 1'b0;
			end
			4'bS10: begin
				if (x == 1'b0)
					state_next = 4'bS;
				else
					state_next = 4'bS1;
				z = x;
			end
			default: begin
				state_next = 4'bS;
				z = 1'b0;
			end
		endcase
	end
endmodule
