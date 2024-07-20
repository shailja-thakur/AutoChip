module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

	reg [2:0] state, state_next;

	always @(posedge clk or negedge aresetn) begin
		if (!aresetn) begin
			state <= 3'b000;
		end else begin
			state <= state_next;
		end
	end

	always @(*) begin
		case (state)
			3'b000: begin
				if (x == 1) begin
					state_next = 3'b001;
				end else begin
					state_next = 3'b000;
				end
				z = 1'b0;
			end
			3'b001: begin
				if (x == 1) begin
					state_next = 3'b001;
				end else begin
					state_next = 3'b010;
				end
				z = 1'b0;
			end
			3'b010: begin
				if (x == 1) begin
					state_next = 3'b001;
				end else begin
					state_next = 3'b000;
				end
				z = x;
			end
		endcase
	end

endmodule
