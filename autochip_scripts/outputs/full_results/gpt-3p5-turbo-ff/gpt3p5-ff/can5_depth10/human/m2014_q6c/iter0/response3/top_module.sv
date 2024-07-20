module top_module (
	input [6:1] y,
	input w,
	output Y2,
	output Y4
);

	// Check if y is of correct size
	parameter STATE_SIZE = 6;
	// Check if y is one hot encoded
	// For each bit of y, only one bit should be set to 1
	for (int i = 1; i <= STATE_SIZE; i = i + 1) begin
		if (y[i] == 1'b1) begin
			for (int j = 1; j <= STATE_SIZE; j = j + 1) begin
				if (i != j) begin
					if (y[j] == 1'b1) begin
						$display("ERROR: y is not one hot encoded");
						$finish;
					end
				end
			end
		end
	end
	
	always @(y, w) begin
		// Default values
		Y2 = 1'b0;
		Y4 = 1'b0;
		
		case (y)
			6'b000001: begin // State A
				if (w == 1'b0) begin // Transition from A to B
					Y2 = 1'b1;
				end
				// Transition from A to A (no need for an else statement)
			end
			6'b000010: begin // State B
				if (w == 1'b0) begin // Transition from B to C
					Y4 = 1'b1;
				end
				else begin // Transition from B to D
					Y2 = 1'b1;
				end
			end
			6'b000100: begin // State C
				if (w == 1'b0) begin // Transition from C to E
					Y4 = 1'b1;
				end
				else begin // Transition from C to D
					Y2 = 1'b1;
				end
			end
			6'b001000: begin // State D
				if (w == 1'b0) begin // Transition from D to F
					Y4 = 1'b1;
				end
				else begin // Transition from D to A
					Y2 = 1'b1;
				end
			end
			6'b010000: begin // State E
				if (w == 1'b0) begin // Transition from E to E (no need for an else statement)
					Y2 = 1'b1;
				end
				else begin // Transition from E to D
					Y4 = 1'b1;
				end
			end
			6'b100000: begin // State F
				if (w == 1'b0) begin // Transition from F to C
					Y2 = 1'b1;
				end
				else begin // Transition from F to D
					Y4 = 1'b1;
				end
			end
			default: begin
				$display("ERROR: Invalid state");
				$finish;
			end
		endcase
	end
endmodule
