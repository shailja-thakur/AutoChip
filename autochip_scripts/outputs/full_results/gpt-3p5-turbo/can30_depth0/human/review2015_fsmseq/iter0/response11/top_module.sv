module top_module(
	input clk,
	input reset,
	input data,
	output start_shifting);

	reg [2:0] state;
	parameter IDLE = 3'b000;
	parameter S1 = 3'b001;
	parameter S2 = 3'b010;
	parameter S3 = 3'b011;
	parameter S4 = 3'b100;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= IDLE;
		end else begin
			case (state)
				IDLE: begin
					if (data) begin
						state <= S1;
					end else begin
						state <= IDLE;
					end
				end

				S1: begin
					if (data) begin
						state <= S2;
					end else begin
						state <= IDLE;
					end
				end

				S2: begin
					if (data) begin
						state <= S3;
					end else begin
						state <= IDLE;
					end
				end

				S3: begin
					if (data) begin
						state <= S4;
					end else begin
						state <= IDLE;
					end
				end

				S4: begin
					if (data) begin
						start_shifting <= 1;
						state <= S4;
					end else begin
						state <= IDLE;
					end
				end
			endcase
		end
	end
endmodule
