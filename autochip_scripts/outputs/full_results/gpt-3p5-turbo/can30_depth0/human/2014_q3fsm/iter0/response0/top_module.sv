module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);
	
	reg [1:0] state, next_state;
	reg [1:0] count;
	
	always @(posedge clk, posedge reset) begin
		if (reset) begin
			state <= 2'b00;
			count <= 2'b00;
			z <= 0;
		end else begin
			state <= next_state;
			count <= count + 1;
			z <= 0;
		end
	end
	
	always @(state, w, count) begin
		case (state)
			2'b00: begin // State A
				next_state <= (s == 1) ? 2'b01 : 2'b00;
			end
			2'b01: begin // State B
				if (count == 2) begin
					next_state <= (w == 1) ? 2'b10 : 2'b11;
				end else begin
					next_state <= 2'b01;
				end
			end
			2'b10: begin // Set Output
				next_state <= 2'b00;
				z <= 1;
			end
			2'b11: begin // Reset Counter
				next_state <= 2'b01;
				count <= 2'b00;
			end
			default: next_state <= 2'b00;
		endcase
	end
	
endmodule
