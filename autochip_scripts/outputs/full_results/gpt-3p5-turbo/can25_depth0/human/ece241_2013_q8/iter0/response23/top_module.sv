module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

reg [2:0] state;
reg [1:0] input_reg;

always @(posedge clk or negedge aresetn) begin
	if (!aresetn) begin
		state <= 3'b000;
		input_reg <= 2'b00;
		z <= 1'b0;
	end
	else begin
		input_reg <= {input_reg[0], x};
		case (state)
			3'b000: begin
				if (input_reg == 2'b01)
					state <= 3'b001;
			end
			3'b001: begin
				if (input_reg == 2'b10)
					state <= 3'b010;
				else if (input_reg == 2'b01)
					state <= 3'b001;
				else
					state <= 3'b000;
			end
			3'b010: begin
				if (input_reg == 2'b01) begin
					state <= 3'b011;
					z <= 1'b1;
				end
				else if (input_reg == 2'b10)
					state <= 3'b010;
				else
					state <= 3'b000;
			end
			3'b011: begin
				if (input_reg == 2'b01)
					state <= 3'b001;
				else
					state <= 3'b011;
			end
			default: state <= 3'b000;
		endcase
	end
end

endmodule
