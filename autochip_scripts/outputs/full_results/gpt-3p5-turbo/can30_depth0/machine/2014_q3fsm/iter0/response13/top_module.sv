module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

parameter STATE_A = 0;
parameter STATE_B = 1;
parameter STATE_C = 2;
parameter STATE_S10 = 3;
parameter STATE_S11 = 4;
parameter STATE_S20 = 5;
parameter STATE_S21 = 6;
parameter STATE_S22 = 7;

reg [2:0] state;
reg [2:0] next_state;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= STATE_B;
	end else begin
		state <= next_state;
	end
end

always @(*) begin
	case (state)
		STATE_A: begin
			if (s) begin
				next_state = STATE_B;
			end
		end
		
		STATE_B, STATE_C: begin
			if (w) begin
				next_state = STATE_S11;
			end else begin
				next_state = STATE_S10;
			end
		end
		
		STATE_S10: begin
			if (w) begin
				next_state = STATE_S21;
			end else begin
				next_state = STATE_S20;
			end
		end
		
		STATE_S11: begin
			if (w) begin
				next_state = STATE_S22;
			end else begin
				next_state = STATE_S21;
			end
		end
		
		STATE_S20: begin
			next_state = STATE_B;
		end
		
		STATE_S21: begin
			if (w) begin
				next_state = STATE_C;
			end else begin
				next_state = STATE_B;
			end
		end
		
		STATE_S22: begin
			if (w) begin
				next_state = STATE_B;
			end else begin
				next_state = STATE_C;
			end
		end
	endcase
end

always @(posedge clk or posedge reset) begin
	if (reset) begin
		z <= 0;
	end else begin
		case (state)
			STATE_B, STATE_C: begin
				if (w) begin
					z <= 1;
				end
			end
			
			STATE_S10, STATE_S11: begin
				if (w) begin
					z <= 0;
				end
			end
			
			STATE_S20: begin
				z <= 1;
			end
			
			STATE_S21, STATE_S22: begin
				z <= 0;
			end
		endcase
	end
end

endmodule
