module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output [3:1] g
);

	// state register
	reg [3:1] state;

	// next state register
	reg [3:1] next;

	// always block to update next state
	always @(posedge clk or negedge resetn) begin
		if (!resetn)
			state <= 3'b001;  // set state to A if reset is low
		else begin
			case (state)
				3'b001: begin  // if state is A
					if (r[1])
						next <= 3'b010;  // if r[1] is high, next state is B
					else if (r[2])
						next <= 3'b011;  // if r[2] is high, next state is C
					else if (r[3])
						next <= 3'b100;  // if r[3] is high, next state is D
					else
						next <= 3'b001;  // if none of the bits of r are high, next state is A
				end
				3'b010: begin  // if state is B
					if (r[1])
						next <= 3'b010;  // if r[1] is high, next state is B
					else
						next <= 3'b001;  // if r[1] is low, next state is A
				end
				3'b011: begin  // if state is C
					if (r[2])
						next <= 3'b011;  // if r[2] is high, next state is C
					else
						next <= 3'b001;  // if r[2] is low, next state is A
				end
				3'b100: begin  // if state is D
					if (r[3])
						next <= 3'b100;  // if r[3] is high, next state is D
					else
						next <= 3'b001;  // if r[3] is low, next state is A
				end
			endcase
		end
	end

	// assign g based on current state
	assign g[1] = (state == 3'b010) ? 1'b1 : 1'b0;  // if current state is B, g[1] is high
	assign g[2] = (state == 3'b011) ? 1'b1 : 1'b0;  // if current state is C, g[2] is high
	assign g[3] = (state == 3'b100) ? 1'b1 : 1'b0;  // if current state is D, g[3] is high

endmodule
