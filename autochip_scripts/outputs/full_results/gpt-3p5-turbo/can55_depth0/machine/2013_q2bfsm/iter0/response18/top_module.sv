module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output f,
	output g
);
	
	reg [3:0] state;
	reg f;
	reg g;
	
	always @(posedge clk or negedge resetn) begin
		if (~resetn) begin
			state <= 4'b0000; // A state
		end else begin
			case (state)
				4'b0000: begin // A state
					if (x) begin
						state <= 4'b0010; // B state
					end
				end
				4'b0010: begin // B state
					state <= 4'b0000; // A state
				end
				4'b0100: begin // S0 state
					if (x) begin
						state <= 4'b0101; // S1 state
					end else begin
						state <= 4'b0100; // S0 state
					end
				end
				4'b0101: begin // S1 state
					if (x) begin
						state <= 4'b0101; // S1 state
					end else begin
						state <= 4'b1010; // S10 state
					end
				end
				4'b1010: begin // S10 state
					if (x) begin
						state <= 4'b1100; // G1 state
					end else begin
						state <= 4'b0100; // S0 state
					end
				end
				4'b1100: begin // G1 state
					if (y) begin
						state <= 4'b1110; // P1 state
					end else begin
						state <= 4'b1000; // G2 state
					end
				end
				4'b1000: begin // G2 state
					if (y) begin
						state <= 4'b1110; // P1 state
					end else begin
						state <= 4'b1000; // G2 state
					end
				end
				4'b1110: begin // P1 state
					state <= 4'b1110; // P1 state
				end
			endcase
		end
	end
	
	always @(state) begin
		f = (state == 4'b0010); // B state
		g = (state == 4'b1100) | (state == 4'b1000) | (state == 4'b1110); // G1 or G2 or P1 state
	end

endmodule
