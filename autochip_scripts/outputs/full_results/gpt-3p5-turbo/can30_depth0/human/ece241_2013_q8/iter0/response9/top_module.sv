module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

	reg [1:0] state = 2'b00;
	reg prev_x = 1'b0;

	always @(posedge clk or negedge aresetn) begin
		if (!aresetn)
			state <= 2'b00;
		else begin
			case (state)
				2'b00: begin
					if (prev_x && !x)
						state <= 2'b01;
				end
				2'b01: begin
					if (!prev_x && x)
						state <= 2'b10;
					else if (prev_x && !x)
						state <= 2'b01;
					else
						state <= 2'b00;
				end
				2'b10: begin
					if (prev_x && !x)
						state <= 2'b11;
					else if (!prev_x && x)
						state <= 2'b10;
					else
						state <= 2'b00;
				end
				2'b11: begin
					if (prev_x && !x)
						state <= 2'b01;
					else if (!prev_x && x)
						state <= 2'b10;
					else
						state <= 2'b00;
				end
				default: state <= 2'b00;
			endcase
		end
	end

	always @(posedge clk) begin
		if (state == 2'b11)
			z <= 1'b1;
		else
			z <= 1'b0;
	end

	assign prev_x = x;

endmodule
