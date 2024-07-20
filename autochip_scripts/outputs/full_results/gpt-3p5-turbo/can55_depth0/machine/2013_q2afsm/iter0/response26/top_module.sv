module top_module (
	input clk,
	input resetn,
	input [2:0] r,
	output [2:0] g
);
	reg [1:0] state;
	reg [1:0] next_state;

	always @(posedge clk or negedge resetn) begin
		if (~resetn) begin
			state <= 2'b00;  // initialize state to A
		end else begin
			state <= next_state;  // update state
		end
	end

	always @(*) begin
		case (state)
			2'b00: begin  // state A
				if (r[2]) begin
					next_state = 2'b10;  // next state B
				end else if (r[1]) begin
					next_state = 2'b11;  // next state C
				end else if (r[0]) begin
					next_state = 2'b01;  // next state D
				end else begin
					next_state = 2'b00;  // next state A
				end
			end
			2'b01: begin  // state B
				if (r[1]) begin
					next_state = 2'b01;  // next state B
				end else begin
					next_state = 2'b00;  // next state A
				end
			end
			2'b10: begin  // state C
				if (r[2]) begin
					next_state = 2'b10;  // next state C
				end else begin
					next_state = 2'b00;  // next state A
				end
			end
			2'b11: begin  // state D
				if (r[0]) begin
					next_state = 2'b11;  // next state D
				end else begin
					next_state = 2'b00;  // next state A
				end
			end
		endcase
	end

	always @(state) begin
		case (state)
			2'b01: begin  // state B
				g[2] = 1'b1;
			end
			2'b10: begin  // state C
				g[1] = 1'b1;
			end
			2'b11: begin  // state D
				g[0] = 1'b1;
			end
			default: begin
				g[2:0] = 3'b0;  // default all bits of g to low
			end
		endcase
	end
endmodule
