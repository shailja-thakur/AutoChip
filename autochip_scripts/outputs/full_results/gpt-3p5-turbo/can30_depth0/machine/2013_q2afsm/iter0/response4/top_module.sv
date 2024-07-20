module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output [3:1] g
);
	reg [3:1] state;
	reg [3:1] next;

	always @(posedge clk or negedge resetn) begin
		if (!resetn) begin
			state <= 3'b001; // State A
		end else begin
			state <= next; // Transition to next state
		end
	end

	always @(*) begin
		case(state)
			3'b001: begin // State A
				next = r[1] ? 3'b010 : (r[2] ? 3'b011 : (r[3] ? 3'b100 : 3'b001)); // A -> B -> C -> D -> A
			end
			3'b010: begin // State B
				next = r[1] ? 3'b010 : 3'b001; // Stay in B if r[1] is high, otherwise transition to A
			end
			3'b011: begin // State C
				next = r[2] ? 3'b011 : 3'b001; // Stay in C if r[2] is high, otherwise transition to A
			end
			3'b100: begin // State D
				next = r[3] ? 3'b100 : 3'b001; // Stay in D if r[3] is high, otherwise transition to A
			end
		endcase
	end

	assign g[1] = (state == 3'b010) ? 1'b1 : 1'b0; // Set g[1] high when in state B
	assign g[2] = (state == 3'b011) ? 1'b1 : 1'b0; // Set g[2] high when in state C
	assign g[3] = (state == 3'b100) ? 1'b1 : 1'b0; // Set g[3] high when in state D
endmodule
