module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output out
);
	// state enumeration
	typedef enum logic [1:0] {
		OFF,
		ON
	} state_t;

	reg state;
	reg next_state;
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= OFF; // initial state
		end else begin
			state <= next_state;
		end
	end

	always @(state or j or k) begin
		case (state)
			OFF: begin
				if (j) begin
					next_state = ON;
				end else begin
					next_state = OFF;
				end
			end
			
			ON: begin
				if (k) begin
					next_state = OFF;
				end else begin
					next_state = ON;
				end
			end
		endcase
	end

	assign out = (state == ON) ? 1'b1 : 1'b0;
endmodule
