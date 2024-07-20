module top_module(
	input clk,
	input reset,
	output shift_ena);

	reg [2:0] state, next_state;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 3'b000;
		end else begin
			state <= next_state;
		end
	end

	always @(state) begin
		case (state)
			3'b000: begin
				if (bit_pattern_detected) begin
					next_state <= 3'b001;
				end else begin
					next_state <= 3'b000;
				end
			end
			3'b001: begin
				next_state <= 3'b010;
			end
			3'b010: begin
				next_state <= 3'b011;
			end
			3'b011: begin
				next_state <= 3'b100;
			end
			3'b100: begin
				next_state <= 3'b000;
			end
			default: begin
				next_state <= 3'b000;
			end
		endcase
	end

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			shift_ena <= 1'b1;
		end else begin
			shift_ena <= 1'b0;
		end
	end
	
endmodule
