module top_module (
	input clk,
	input reset,
	input x,
	output reg z
);
	reg [2:0] state;

	always @(posedge clk, posedge reset) begin
		if (reset) begin
			state <= 3'b001; // initialize to state A
		end else begin
			case (state)
				3'b000: // state A
					if (x) begin
						state <= 3'b001; // next state is B
					end else begin
						state <= 3'b000; // next state is A
					end
				3'b001: // state B
					if (x) begin
						state <= 3'b100; // next state is E
					end else begin
						state <= 3'b001; // next state is B
					end
				3'b010: // state C
					if (x) begin
						state <= 3'b001; // next state is B
					end else begin
						state <= 3'b010; // next state is C
					end
				3'b011: // state D
					if (x) begin
						state <= 3'b010; // next state is C
					end else begin
						state <= 3'b001; // next state is B
					end
				3'b100: // state E
					if (x) begin
						state <= 3'b100; // next state is E
					end else begin
						state <= 3'b011; // next state is D
					end
				default:
					state <= 3'b001; // default to state A
			endcase
		end
	end

	always @(state) begin
		if (state == 3'b100 || state == 3'b101) begin // state D or E
			z <= 1'b1; // output high
		end else begin
			z <= 1'b0; // output low
		end
	end
endmodule
