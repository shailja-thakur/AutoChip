module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

reg [1:0] state, next_state;
reg [2:0] w_count;

localparam A = 2'b00, B = 2'b01;
wire count_equals_two;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= A;
		w_count <= 3'b0;
	end else begin
		state <= next_state;
		w_count <= (w_count == 3'b111) ? 3'b000 : w_count + 1;
	end
end

always @(state or w) begin
	case (state)
		A: begin
			if (s == 1'b0) begin
				next_state = A;
				z = 1'b0;
			end else begin
				next_state = B;
				z = 1'b0;
			end
		end

		B: begin
			if (w_count == 3'b110) begin
				if (w == 1'b1 || count_equals_two) begin
					next_state = A;
					z = 1'b1;
				end else begin
					next_state = A;
					z = 1'b0;
				end
			end else begin
				next_state = B;
				z = 1'b0;
			end
		end
	endcase
end

assign count_equals_two = (w_count == 3'b110 && w != 1'b0);

endmodule
