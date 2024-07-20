module top_module(
	input clk,
	input reset,
	output shift_ena);

	reg [2:0] state;
	reg [3:0] count;
	reg shift_ena;

	parameter S0 = 3'b000;
	parameter S1 = 3'b001;
	parameter S2 = 3'b010;
	parameter S3 = 3'b011;
	parameter S4 = 3'b100;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= S0;
			count <= 0;
			shift_ena <= 1;
		end else begin
			case (state)
				S0: begin
					if (input_pattern_detected) begin
						state <= S1;
						count <= 0;
						shift_ena <= 1;
					end
				end
				S1: begin
					if (count < 3) begin
						state <= S1;
						count <= count + 1;
						shift_ena <= 1;
					end else begin
						state <= S2;
						count <= 0;
						shift_ena <= 0;
					end
				end
				S2: begin
					state <= S3;
					count <= 0;
					shift_ena <= 0;
				end
				S3: begin
					if (reset) begin
						state <= S0;
						count <= 0;
						shift_ena <= 1;
					end else begin
						state <= S4;
						count <= 0;
						shift_ena <= 0;
					end
				end
				S4: begin
					state <= S4;
					count <= count + 1;
					shift_ena <= 0;
				end
			endcase
		end
	end

endmodule
