module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output out
);

	parameter OFF = 1'b0; // state OFF
	parameter ON = 1'b1; // state ON

	reg [1:0] curr_state, next_state;

	always @(posedge clk or posedge areset) begin
		if (areset) begin
			curr_state <= OFF;
		end
		else begin
			curr_state <= next_state;
		end
	end

	always @(curr_state, j, k) begin
		case (curr_state)
			OFF: begin
				if (j) begin
					next_state = ON;
				end
				else begin
					next_state = OFF;
				end
			end

			ON: begin
				if (k) begin
					next_state = OFF;
				end
				else begin
					next_state = ON;
				end
			end
		endcase
	end

	always @(curr_state) begin
		case (curr_state)
			OFF: begin
				out = 1'b0;
			end

			ON: begin
				out = 1'b1;
			end
		endcase
	end

endmodule
