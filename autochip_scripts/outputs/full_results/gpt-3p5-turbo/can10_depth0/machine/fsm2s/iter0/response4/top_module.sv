module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output out
);
	reg state, next_state;
	
	always @(posedge clk) begin
		if (reset) begin
			state <= 0;
		end else begin
			state <= next_state;
		end
	end
	
	always @(*) begin
		case (state)
			0: begin
				if (j) begin
					next_state = 1;
				end else begin
					next_state = 0;
				end
			end
			
			1: begin
				if (k) begin
					next_state = 0;
				end else begin
					next_state = 1;
				end
			end
		endcase
	end
	
	assign out = (state == 1) ? 1 : 0;
	
endmodule
