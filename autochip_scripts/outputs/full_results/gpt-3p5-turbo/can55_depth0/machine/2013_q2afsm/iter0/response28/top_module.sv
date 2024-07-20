module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output [3:1] g
);
	reg [1:0] state;
	reg [1:0] next_state;

	always @(posedge clk) begin
		if (~resetn) begin
			state <= 2'b00;  // set state to A when resetn is low
		end else begin
			state <= next_state;
		end
	end

	always @(*) begin
		case (state)
			2'b00: begin  // state A
				if (r[1]) begin
					next_state = 2'b01;  // next state is B if r[1] is high
				end else if (r[2]) begin
					next_state = 2'b10;  // next state is C if r[2] is high
				end else if (r[3]) begin
					next_state = 2'b11;  // next state is D if r[3] is high
				end else begin
					next_state = 2'b00;  // next state is A if none of the bits of r are high
				end
			end
			2'b01: begin  // state B
				if (r[1]) begin
					next_state = 2'b01;  // next state is B if r[1] is high
				end else begin
					next_state = 2'b00;  // next state is A if r[1] is low
				end
			end
			2'b10: begin  // state C
				if (r[2]) begin
					next_state = 2'b10;  // next state is C if r[2] is high
				end else begin
					next_state = 2'b00;  // next state is A if r[2] is low
				end
			end
			2'b11: begin  // state D
				if (r[3]) begin
					next_state = 2'b11;  // next state is D if r[3] is high
				end else begin
					next_state = 2'b00;  // next state is A if r[3] is low
				end
			end
		endcase
	end

	assign g[1] = (state == 2'b01) ? 1'b1 : 1'b0;  // g[1] is high if current state is B
	assign g[2] = (state == 2'b10) ? 1'b1 : 1'b0;  // g[2] is high if current state is C
	assign g[3] = (state == 2'b11) ? 1'b1 : 1'b0;  // g[3] is high if current state is D
endmodule
