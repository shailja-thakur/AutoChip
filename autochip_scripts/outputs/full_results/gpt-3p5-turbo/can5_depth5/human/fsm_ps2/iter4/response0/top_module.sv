module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg done
);

reg [2:0] state;
reg [2:0] next_state;
reg reset_d;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 3'b000;
		reset_d <= 1'b1;
	end else begin
		reset_d <= 1'b0;
		state <= next_state;
	end
end

always @(state, in) begin
	case (state)
		3'b000: begin
			if (reset_d == 1'b1 || in[3] == 1'b1) begin
				next_state = 3'b001;
			end else begin
				next_state = 3'b000;
			end
		end
		3'b001: begin
			if (reset_d == 1'b1) begin
				next_state = 3'b010;
			end else begin
				next_state = 3'b000;
			end
		end
		3'b010: begin
			if (reset_d == 1'b1 || in[3] == 1'b1) begin
				next_state = 3'b011;
			end else begin
				next_state = 3'b000;
			end
		end
		3'b011: begin
			next_state = 3'b000;
		end
	endcase
end

always @(posedge clk) begin
	if (state == 3'b011) begin
		done <= 1'b1;
	end else begin
		done <= 1'b0;
	end
end

endmodule
