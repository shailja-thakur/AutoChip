module top_module (
	input clk,
	input x,
	input [2:0] y,
	output reg Y0,
	output reg z
);

	// State transition and output logic
	always @(posedge clk) begin
		case (y)
			3'b000: begin
				if (x == 1'b0) begin
					Y0 <= 1'b0; // Next state will be 000
				end else begin
					Y0 <= 1'b1; // Next state will be 001
				end
				z <= 1'b0; // output
			end

			3'b001: begin
				if (x == 1'b0) begin
					Y0 <= 1'b1; // Next state will be 001
				end else begin
					Y0 <= 1'b0; // Next state will be 100
				end
				z <= 1'b0; // output
			end

			3'b010: begin
				if (x == 1'b0) begin
					Y0 <= 1'b0; // Next state will be 010
				end else begin
					Y0 <= 1'b1; // Next state will be 001
				end
				z <= 1'b0; // output
			end

			3'b011: begin
				if (x == 1'b0) begin
					Y0 <= 1'b1; // Next state will be 001
				end else begin
					Y0 <= 1'b0; // Next state will be 010
				end
				z <= 1'b1; // output
			end

			3'b100: begin
				if (x == 1'b0) begin
					Y0 <= 1'b1; // Next state will be 011
				end else begin
					Y0 <= 1'b0; // Next state will be 100
				end
				z <= 1'b1; // output
			end

			default: begin
				Y0 <= 1'b0;
				z <= 1'b0;
			end
		endcase
	end

endmodule
