module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output [3:1] g
);

	reg [3:1] state;
	reg [3:1] next;

	always @(posedge clk) begin
		if (resetn == 0) begin
			state <= 3'b001;  // Set state to A
		end else begin
			state <= next;  // Set state to next state
		end
	end

	always @* begin
		case (state)
			3'b001: begin // State A
				if (r[1] == 1) begin
					next = 3'b010; // Next state is B
				end else if (r[2] == 1) begin
					next = 3'b011; // Next state is C
				end else if (r[3] == 1) begin
					next = 3'b100; // Next state is D
				end else begin
					next = 3'b001; // Next state is A
				end
			end
			3'b010: begin // State B
				if (r[1] == 1) begin
					next = 3'b010; // Next state is B
				end else begin
					next = 3'b001; // Next state is A
				end
			end
			3'b011: begin // State C
				if (r[2] == 1) begin
					next = 3'b011; // Next state is C
				end else begin
					next = 3'b001; // Next state is A
				end
			end
			3'b100: begin // State D
				if (r[3] == 1) begin
					next = 3'b100; // Next state is D
				end else begin
					next = 3'b001; // Next state is A
				end
			end
			default: begin
				next = 3'b001; // Next state is A
			end
		endcase
	end

	assign g[1] = (state == 3'b010) ? 1'b1 : 1'b0; // g[1] is high when in state B
	assign g[2] = (state == 3'b011) ? 1'b1 : 1'b0; // g[2] is high when in state C
	assign g[3] = (state == 3'b100) ? 1'b1 : 1'b0; // g[3] is high when in state D
endmodule
