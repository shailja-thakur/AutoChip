module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

reg [2:0] state;
reg [2:0] next_state;

always @(posedge clk or negedge aresetn) begin
	if (~aresetn) begin
		state <= 3'b000;
	end else begin
		state <= next_state;
	end
end

always @(state or x) begin
	case (state)
		3'b000: begin
			if (x == 1'b1) begin
				next_state = 3'b001;
			end else begin
				next_state = 3'b000;
			end
		end
		3'b001: begin
			if (x == 1'b0) begin
				next_state = 3'b010;
			end else begin
				next_state = 3'b000;
			end
		end
		3'b010: begin
			if (x == 1'b1) begin
				next_state = 3'b011;
			end else begin
				next_state = 3'b000;
			end
		end
		3'b011: begin
			if (x == 1'b0) begin
				next_state = 3'b101;
			end else begin
				next_state = 3'b000;
			end
		end
		default: begin
			next_state = 3'b000;
		end
	endcase
end

always @(state) begin
	if (state == 3'b101) begin
		z <= 1'b1;
	else
		z <= 1'b0;
	end
end

endmodule
