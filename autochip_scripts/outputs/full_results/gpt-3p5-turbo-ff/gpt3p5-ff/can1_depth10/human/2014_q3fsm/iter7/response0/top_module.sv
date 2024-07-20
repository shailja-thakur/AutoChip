module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

reg [1:0] state;
reg [2:0] w_count;
reg [2:0] next_w_count;

always @(posedge clk) begin
	if (reset) begin
		state <= 0;
		w_count <= 0;
		z <= 0;
	end
	else begin
		case (state)
			0: begin // State A
				if (s == 1)
					state <= 1; // Move to state B if s = 1
			end
			1: begin // State B
				next_w_count <= w_count;
				next_w_count[2:0] <= {next_w_count[1:0], w};
				
				w_count <= next_w_count;
				
				if (w_count[2:0] == 3'b011)
					z <= 1; // Set output z to 1 in the following clock cycle if w = 1 in exactly two clock cycles
				else
					z <= 0; // Set output z to 0 otherwise
				
				state <= 0; // Move back to state A
			end
		endcase
	end
end

endmodule
