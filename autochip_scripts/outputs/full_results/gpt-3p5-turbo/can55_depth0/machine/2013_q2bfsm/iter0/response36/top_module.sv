module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output f,
	output g
);
	reg [3:0] state, next_state;

	always @(posedge clk or negedge resetn) begin
		if (!resetn) begin
			state <= 4'b0000; // A state
		end else begin
			state <= next_state;
		end
	end

	always @(state or x) begin
		case (state)
			4'b0000: begin // A state
				if (x) begin
					next_state = 4'b0010; // B state
				end else begin
					next_state = 4'b0000; // A state
				end
			end
			4'b0010: begin // B state
				next_state = 4'b0001; // S0 state
			end
			4'b0001: begin // S0 state
				if (x) begin
					next_state = 4'b0011; // S1 state
				end else begin
					next_state = 4'b0001; // S0 state
				end
			end
			4'b0011: begin // S1 state
				if (x) begin
					next_state = 4'b0011; // S1 state
				end else begin
					next_state = 4'b1010; // S10 state
				end
			end
			4'b1010: begin // S10 state
				if (x) begin
					next_state = 4'b1101; // G1 state
				end else begin
					next_state = 4'b0001; // S0 state
				end
			end
			4'b1101: begin // G1 state
				if (y) begin
					next_state = 4'b1110; // P1 state
				end else begin
					next_state = 4'b0110; // G2 state
				end
			end
			4'b0110: begin // G2 state
				if (y) begin
					next_state = 4'b1110; // P1 state
				end else begin
					next_state = 4'b0100; // P0 state
				end
			end
			4'b0100: begin // P0 state
				next_state = 4'b0100; // P0 state
			end
			4'b1110: begin // P1 state
				next_state = 4'b1110; // P1 state
			end
			default: begin
				next_state = 4'b0000; // A state (default when unexpected state occurs)
			end
		endcase
	end

	assign f = (state == 4'b0010) ? 1'b1 : 1'b0; // f is assigned to 1 when the state is B
	assign g = (state == 4'b1101 || state == 4'b0110 || state == 4'b1110) ? 1'b1 : 1'b0; // g is assigned to 1 when the state is G1 or G2 or P1

endmodule
