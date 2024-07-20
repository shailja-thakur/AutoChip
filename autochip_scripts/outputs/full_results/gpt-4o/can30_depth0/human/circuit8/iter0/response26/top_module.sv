module top_module (
	input clock,
	input a,
	output reg p,
	output reg q
);

	reg state;
	
	// State definition
	localparam IDLE = 0, SET = 1;
	
	always @(posedge clock) begin
		// State transition
		case (state)
			IDLE: begin
				if (a) begin
					state <= SET;
					p <= 1;
				end else begin
					p <= 0;
				end
			end
			SET: begin
				if (!a) begin
					state <= IDLE;
					p <= 0;
				end else begin
					p <= 1;
				end
			end
			default: state <= IDLE;
		endcase
	end
	
	always @(negedge clock) begin
		// Output logic for q
		if (state == SET && !a) begin
			q <= 0;
		end else if (state == SET && a) begin
			q <= 1;
		end else if (state == IDLE && !a) begin
			q <= 0;
		end else if (state == IDLE && a) begin
			q <= 1;
		end
	end
	
	initial begin
		state = IDLE;
		p = 0;
		q = 0;
		observation = IDLE;
	end

endmodule
