module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output [3:1] g
);

	reg [3:1] state;
	reg [3:1] next_state;

	always @(posedge clk) begin
		if (!resetn) begin
			state <= 3'b001; // state A
		end else begin
			state <= next_state;
		end
	end

	always @(*) begin
		case (state)
			3'b001: begin // state A
				if (r[1]) begin
					next_state = 3'b010; // state B
				end else if (r[2]) begin
					next_state = 3'b011; // state C
				end else if (r[3]) begin
					next_state = 3'b100; // state D
				end else begin
					next_state = 3'b001; // state A
				end
			end
			
			3'b010: begin // state B
				if (r[1]) begin
					next_state = 3'b010; // state B
				end else begin
					next_state = 3'b001; // state A
				end
			end
			
			3'b011: begin // state C
				if (r[2]) begin
					next_state = 3'b011; // state C
				end else begin
					next_state = 3'b001; // state A
				end
			end
			
			3'b100: begin // state D
				if (r[3]) begin
					next_state = 3'b100; // state D
				end else begin
					next_state = 3'b001; // state A
				end
			end
		endcase
	end

	assign g[1] = (state == 3'b010) ? 1'b1 : 1'b0; // state B
	assign g[2] = (state == 3'b011) ? 1'b1 : 1'b0; // state C
	assign g[3] = (state == 3'b100) ? 1'b1 : 1'b0; // state D

endmodule
