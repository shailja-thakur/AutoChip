module top_module (
	input clk,
	input areset,
	input x,
	output z
);

	reg [1:0] state;
	reg [0:0] z_temp;
	wire z;

	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= 2'b0;
			z_temp <= 1'b0;
		end else begin
			case (state)
				2'b00: begin
					if (x == 1'b1)
						state <= 2'b01;
				end
				2'b01: begin
					state <= 2'b00;
				end
			endcase
		end
	end

	always @(posedge clk) begin
		if (state == 2'b00)
			z_temp <= ~x;
	end

	assign z = z_temp;

endmodule
