module top_module(
 	input x,
 	input y,
 	output z);

	// Declare internal signals
	reg x_reg, y_reg;
	wire x_next, y_next, z_next;
	
	// Register for x input
	always @(posedge clk) begin
		x_reg <= x;
	end
	
	// Register for y input
	always @(posedge clk) begin
		y_reg <= y;
	end
	
	// Next-state logic for x input
	always @(x_reg, y_reg) begin
		case ({x_reg, y_reg})
			2'b00: x_next = 1'b1;
			2'b01: x_next = 1'b0;
			2'b10: x_next = 1'b1;
			2'b11: x_next = 1'b0;
		endcase
	end
	
	// Next-state logic for y input
	always @(x_reg, y_reg) begin
		case ({x_reg, y_reg})
			2'b00: y_next = 1'b1;
			2'b01: y_next = 1'b1;
			2'b10: y_next = 1'b0;
			2'b11: y_next = 1'b1;
		endcase
	end
	
	// Next-state logic for z output
	always @(x_reg, y_reg) begin
		case ({x_reg, y_reg})
			2'b00: z_next = 1'b1;
			2'b01: z_next = 1'b0;
			2'b10: z_next = 1'b0;
			2'b11: z_next = 1'b1;
		endcase
	end
	
	// Output assignment
	assign z = z_next;
	
endmodule
