module top_module (
	input clk,
	input areset,
	input x,
	output z
);

	reg [3:0] state;
	reg [3:0] next_state;

	parameter S0 = 0;
	parameter S1 = 1;
	parameter S2 = 2;
	parameter S3 = 3;

	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= S0;
		end else begin
			state <= next_state;
		end
	end

	always @(state, x) begin
		case (state)
			S0: begin
				if (areset) begin
					next_state <= S0;
					z <= 0;
				end else begin
					next_state <= S1;
					z <= ~x;
				end
			end
			S1: begin
				next_state <= S2;
				z <= ~x;
			end
			S2: begin
				next_state <= S3;
				z <= ~x;
			end
			S3: begin
				next_state <= S3;
				z <= ~x;
			end
			default: begin
				next_state <= S0;
				z <= 0;
			end
		endcase
	end
endmodule
