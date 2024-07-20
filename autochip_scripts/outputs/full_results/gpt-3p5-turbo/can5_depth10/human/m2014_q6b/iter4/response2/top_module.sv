module top_module(
	input [3:1] y,
	input w,
	output reg Y2);

	always @(*) begin
		case (y)
			3'b000: Y2 = 1'b0; // A -> B
			3'b001: Y2 = 1'b1; // B -> A
			3'b010: Y2 = 1'b1; // C -> D
			3'b011: Y2 = 1'b0; // D -> A
			3'b100: Y2 = 1'b0; // E -> D
			3'b101: Y2 = 1'b1; // F -> D
			default: Y2 = 1'b0; // Default
		endcase
	end

	initial begin
		$dumpfile("wave.vcd");
		$dumpvars(0);
		
		// Test vector 1
		w = 1'b0;
		y = 3'b000;
		#10;
		
		// Test vector 2
		w = 1'b1;
		y = 3'b000;
		#10;
		
		// Test vector 3
		w = 1'b0;
		y = 3'b001;
		#10;
		
		// Test vector 4
		w = 1'b1;
		y = 3'b001;
		#10;
		
		// Test vector 5
		w = 1'b0;
		y = 3'b010;
		#10;
		
		// Test vector 6
		w = 1'b1;
		y = 3'b010;
		#10;
		
		// Test vector 7
		w = 1'b0;
		y = 3'b011;
		#10;
		
		// Test vector 8
		w = 1'b1;
		y = 3'b011;
		#10;
		
		// Test vector 9
		w = 1'b0;
		y = 3'b100;
		#10;
		
		// Test vector 10
		w = 1'b1;
		y = 3'b100;
		#10;
		
		// Test vector 11
		w = 1'b0;
		y = 3'b101;
		#10;
		
		// Test vector 12
		w = 1'b1;
		y = 3'b101;
		#10;
		
		// End simulation
		$finish;
	end

endmodule
