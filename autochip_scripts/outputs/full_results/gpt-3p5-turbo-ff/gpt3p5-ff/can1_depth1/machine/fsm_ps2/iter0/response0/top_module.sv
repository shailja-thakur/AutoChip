module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg done
);

reg [2:0] state;

// State machine
always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 3'b000;
	end else begin
		case (state)
			3'b000: begin
				if (in[2] == 1) begin
					state <= 3'b001;
				end else begin
					state <= 3'b000;
				end
			end
			3'b001: begin
				state <= 3'b010;
			end
			3'b010: begin
				state <= 3'b011;
			end
			3'b011: begin
				state <= 3'b100;
			end
			3'b100: begin
				if (in[2] == 1) begin
					state <= 3'b001;
				end else begin
					state <= 3'b010;
				end
			end
		endcase
	end
end

assign done = (state == 3'b100);

endmodule
