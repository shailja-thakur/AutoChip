module top_module (
	input clk,
	input x,
	input [2:0] y,
	output reg Y0,
	output reg z
);
	always @(posedge clk) begin
		case ({y[2], y[1], y[0]})
			3'b000: begin // Present state: 000
				if (x == 1) begin
					Y <= 3'b001; // Next state for x=1: 001
					z <= 1;
				end else begin
					Y <= 3'b000; // Next state for x=0: 000
					z <= 0;
				end
			end
			3'b001: begin // Present state: 001
				if (x == 1) begin
					Y <= 3'b100; // Next state for x=1: 100
					z <= 0;
				end else begin
					Y <= 3'b001; // Next state for x=0: 001
					z <= 0;
				end
			end
			3'b010: begin // Present state: 010
				if (x == 1) begin
					Y <= 3'b001; // Next state for x=1: 001
					z <= 0;
				end else begin
					Y <= 3'b010; // Next state for x=0: 010
					z <= 0;
				end
			end
			3'b011: begin // Present state: 011
				if (x == 1) begin
					Y <= 3'b010; // Next state for x=1: 010
					z <= 1;
				end else begin
					Y <= 3'b001; // Next state for x=0: 001
					z <= 0;
				end
			end
			3'b100: begin // Present state: 100
				if (x == 1) begin
					Y <= 3'b100; // Next state for x=1: 100
					z <= 1;
				end else begin
					Y <= 3'b011; // Next state for x=0: 011
					z <= 1;
				end
			end
		endcase
	end
endmodule
