module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output reg out
);

	reg [1:0] state;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 2'b0;
		end else begin
			case (state)
				2'b00: begin  // state A
					if (j) begin
						state <= 2'b01;  // transition to state B
					else
						state <= 2'b00;  // remain in state A
					end
				end
				
				2'b01: begin  // state B
					if (k) begin
						state <= 2'b00;  // transition to state A
					else
						state <= 2'b01;  // remain in state B
					end
				end
			endcase
		end
	end

	assign out = (state == 2'b01);

endmodule
