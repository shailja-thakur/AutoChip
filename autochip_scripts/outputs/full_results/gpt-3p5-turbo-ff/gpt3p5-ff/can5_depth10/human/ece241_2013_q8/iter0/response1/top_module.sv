module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);
	// Define the states
	enum {S1, S2, S3} state;

	// Define the next state and output logic
	always @(posedge clk or negedge aresetn) begin
		if (!aresetn) begin
			state <= S1;
			z <= 0;
		end else begin
			case (state)
				S1: begin
					if (x) begin
						state <= S2;
						z <= 0;
					end else begin
						state <= S1;
						z <= 0;
					end
				end
				S2: begin
					if (x) begin
						state <= S3;
						z <= 0;
					end else begin
						state <= S1;
						z <= 0;
					end
				end
				S3: begin
					if (!x) begin
						state <= S1;
						z <= 0;
					end else begin
						state <= S3;
						z <= 1;
					end
				end
				default: begin
					state <= S1;
					z <= 0;
				end
			endcase
		end
	end
endmodule
