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
	if (~resetn) begin
		state <= 4'b0000; // initial state
	end else begin
		state <= next_state;
	end
end

always @(state or x or y) begin
	case (state)
		4'b0000: begin // A
			next_state = 4'b0010; // B
		end
		4'b0010: begin // B
			next_state = 4'b0000; // S0
		end
		4'b0001: begin // S1
			if (x) begin
				next_state = 4'b0001; // S1
			end else begin
				next_state = 4'b1010; // S10
			end
		end
		4'b1010: begin // S10
			if (x) begin
				next_state = 4'b1100; // G1
			end else begin
				next_state = 4'b0000; // S0
			end
		end
		4'b1100: begin // G1
			if (y) begin
				next_state = 4'b0011; // P1
			end else begin
				next_state = 4'b0010; // G2
			end
		end
		4'b0010: begin // G2
			if (y) begin
				next_state = 4'b0011; // P1
			end else begin
				next_state = 4'b0100; // P0
			end
		end
		4'b0100: begin // P0
			next_state = 4'b0100; // P0
		end
		4'b0011: begin // P1
			next_state = 4'b0011; // P1
		end
	endcase
end

assign f = (state == 4'b0010); // B

assign g = (state == 4'b1100) || (state == 4'b0010) || (state == 4'b0011); // G1 or G2 or P1

endmodule
