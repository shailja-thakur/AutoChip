module top_module (
	input clk,
	input areset,
	input x,
	output z
);
	reg [2:0] state;
	reg [2:0] next_state;
	reg [2:0] z_reg;
	      
	always @(posedge clk or negedge areset) begin
		if (areset == 0) begin
			state <= 3'b000;
		end else begin
			state <= next_state;
		end
	end

	always @(*) begin
		case (state)
			3'b000: begin // ST_IDLE
				next_state = (areset == 0) ? 3'b000 : 3'b001;
			end

			3'b001: begin // ST_CONVERT
				next_state = (x == 1) ? 3'b010 : 3'b001;
			end

			3'b010: begin // ST_COMPLEMENT
				next_state = (x == 1) ? 3'b010 : 3'b011;
			end

			3'b011: begin // ST_DONE
				next_state = (areset == 0) ? 3'b000 : 3'b011;
			end
		endcase
	end

	always @(posedge clk) begin
		if (state == 3'b001) begin
			z_reg <= ~x;
		end else if (state == 3'b010) begin
			z_reg <= z_reg - 1;
		end else if (state == 3'b011) begin
			z_reg <= z_reg;
		end
	end

	assign z = z_reg;

endmodule
