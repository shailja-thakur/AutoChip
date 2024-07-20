module top_module (
	input clk,
	input reset,
	input x,
	output reg z
);

	reg [2:0] y; // present state

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			y <= 3'b000; // reset to state 000
		end else begin
			case (y)
				3'b000: begin // Present state 000
					if (x == 1'b0) begin
						y <= 3'b000; // Next state 000, x=0
						z <= 1'b0; // Output z = 0
					end else begin
						y <= 3'b001; // Next state 001, x=1
						z <= 1'b0; // Output z = 0
					end
				end
				3'b001: begin // Present state 001
					if (x == 1'b0) begin
						y <= 3'b001; // Next state 001, x=0
						z <= 1'b0; // Output z = 0
					end else begin
						y <= 3'b100; // Next state 100, x=1
						z <= 1'b0; // Output z = 0
					end
				end
				3'b010: begin // Present state 010
					if (x == 1'b0) begin
						y <= 3'b010; // Next state 010, x=0
						z <= 1'b0; // Output z = 0
					end else begin
						y <= 3'b001; // Next state 001, x=1
						z <= 1'b0; // Output z = 0
					end
				end
				3'b011: begin // Present state 011
					if (x == 1'b0) begin
						y <= 3'b001; // Next state 001, x=0
						z <= 1'b0; // Output z = 0
					end else begin
						y <= 3'b010; // Next state 010, x=1
						z <= 1'b1; // Output z = 1
					end
				end
				3'b100: begin // Present state 100
					if (x == 1'b0) begin
						y <= 3'b011; // Next state 011, x=0
						z <= 1'b1; // Output z = 1
					end else begin
						y <= 3'b100; // Next state 100, x=1
						z <= 1'b1; // Output z = 1
					end
				end
			endcase
		end
	end
endmodule
