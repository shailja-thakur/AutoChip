module top_module(
	input clk,
	input reset,
	input data,
	output start_shifting);

	// Registers
	reg [3:0] state;
	
	// Assignments
	assign start_shifting = (state == 4'b1110) ? 1'b1 : 1'b0;
	
	// Combinational logic
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 4'b0;  // Initial state is S
		end else begin
			case (state)
				4'b0000: begin
					if (data) begin
						state <= 4'b0001;  // Next state is S1
					end else begin
						state <= 4'b0000;  // Next state is S
					end
				end
				4'b0001: begin
					if (data) begin
						state <= 4'b0011;  // Next state is S11
					end else begin
						state <= 4'b0000;  // Next state is S
					end
				end
				4'b0011: begin
					if (data) begin
						state <= 4'b0011;  // Next state is S11
					end else begin
						state <= 4'b0110;  // Next state is S110
					end
				end
				4'b0110: begin
					if (data) begin
						state <= 4'b1110;  // Next state is Done
					end else begin
						state <= 4'b0000;  // Next state is S
					end
				end
				4'b1110: begin
					state <= 4'b1110;  // Next state is Done
				end
				default: begin
					state <= 4'b0000;  // Next state is S
				end
			endcase
		end
	end
endmodule
