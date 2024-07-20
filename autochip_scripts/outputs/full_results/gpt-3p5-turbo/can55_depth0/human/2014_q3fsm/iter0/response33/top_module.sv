module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

reg [1:0] state;
reg [2:0] w_count;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 2'b00; // reset state A
		w_count <= 3'b000;
		z <= 1'b0;
	end else begin
		case (state)
			2'b00: begin // state A
				if (s == 1'b1) begin
					state <= 2'b01; // transition to state B
					w_count <= 3'b000;
				end
			end
			
			2'b01: begin // state B
				w_count <= w_count + 1'b1;
				
				if (w_count == 3'b010) begin
					if (w == 1'b1) begin
						z <= 1'b1;
					end else begin
						z <= 1'b0;
					end
				end

				if (w_count == 3'b111) begin
					w_count <= 3'b000;
				end
			end
		endcase
	end
end

endmodule
