module top_module (
	input clk,
	input reset,
	input [3:1] s,
	output reg fr3,
	output reg fr2,
	output reg fr1,
	output reg dfr
);

	reg [3:0] state, next_state;
	
	localparam BELOW_S1 = 4'b0001,
			  BETWEEN_S1_S2 = 4'b0010,
			  BETWEEN_S2_S3 = 4'b0100,
			  ABOVE_S3 = 4'b1000;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= BELOW_S1;
			fr3 <= 1;
			fr2 <= 1;
			fr1 <= 1;
			dfr <= 1;
		end else begin
			state <= next_state;
		end
	end

	always @(*) begin
		case (state)
			BELOW_S1: begin
				fr3 = 1; fr2 = 1; fr1 = 1; dfr = 0;
				if (s[1]) next_state = BETWEEN_S1_S2;
				else next_state = BELOW_S1;
			end

			BETWEEN_S1_S2: begin
				fr3 = 0; fr2 = 1; fr1 = 1; dfr = 1;
				if (s[2]) next_state = BETWEEN_S2_S3;
				else if (!s[1]) next_state = BELOW_S1;
				else next_state = BETWEEN_S1_S2;
			end

			BETWEEN_S2_S3: begin
				fr3 = 0; fr2 = 0; fr1 = 1; dfr = 1;
				if (s[3]) next_state = ABOVE_S3;
				else if (!s[2]) next_state = BETWEEN_S1_S2;
				else next_state = BETWEEN_S2_S3;
			end

			ABOVE_S3: begin
				fr3 = 0; fr2 = 0; fr1 = 0; dfr = 0;
				if (!s[3]) next_state = BETWEEN_S2_S3;
				else next_state = ABOVE_S3;
			end

			default: begin
				next_state = BELOW_S1; // Default state on erroneous state
			end
		endcase
	end

endmodule
