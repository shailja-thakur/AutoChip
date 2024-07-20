module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

	reg [1:0] state, state_next;

	always @(posedge clk or negedge aresetn) begin
		if (~aresetn) begin
			state <= 2'b0;
		end else begin
			state <= state_next;
		end
	end

	always @* begin
		case(state)
			2'b00: begin
				if (x) begin
					state_next = 2'b01;
				end else begin
					state_next = 2'b00;
				end
				z = 1'b0;
			end
			
			2'b01: begin
				if (x) begin
					state_next = 2'b01;
				end else begin
					state_next = 2'b10;
				end
				z = 1'b0;
			end
			
			2'b10: begin
				if (x) begin
					state_next = 2'b01;
				end else begin
					state_next = 2'b00;
				end
				z = x;
			end
			
			default: begin
				state_next = 2'b00;
				z = 1'b0;
			end
		endcase
	end

endmodule
