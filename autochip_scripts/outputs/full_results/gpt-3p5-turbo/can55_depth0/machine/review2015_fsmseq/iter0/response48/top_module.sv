module top_module(
	input clk,
	input reset,
	input data,
	output start_shifting);

	reg [3:0] state, next_state;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 4'b0000;
		end else begin
			state <= next_state;
		end
	end

	always @(*) begin
		case (state)
			4'b0000: begin  // S
				if (data) begin
					next_state = 4'b0001;  // S1
				end else begin
					next_state = 4'b0000;  // S
				end
			end
			4'b0001: begin  // S1
				if (data) begin
					next_state = 4'b0010;  // S11
				end else begin
					next_state = 4'b0000;  // S
				end
			end
			4'b0010: begin  // S11
				if (data) begin
					next_state = 4'b0010;  // S11
				end else begin
					next_state = 4'b0011;  // S110
				end
			end
			4'b0011: begin  // S110
				if (data) begin
					next_state = 4'b0100;  // Done
				end else begin
					next_state = 4'b0000;  // S
				end
			end
			4'b0100: begin  // Done
				next_state = 4'b0100;  // Done
			end
		endcase
	end

	assign start_shifting = (state == 4'b0100);

endmodule
