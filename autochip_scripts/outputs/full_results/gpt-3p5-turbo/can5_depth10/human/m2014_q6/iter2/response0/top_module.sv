module top_module (
	input clk,
	input reset,
	input w,
	output z
);

	reg [2:0] state;
	
	// Internal registers for next state computation
	reg [2:0] next_state;
	reg [3:0] mismatch_count;
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 3'b000;
			mismatch_count <= 0;
		end
		else begin
			state <= next_state;
			mismatch_count <= mismatch_count + ((state == 3'b101 || state == 3'b100) ^ z); // Count mismatches
		end
	end
	
	always @(state, w) begin
		case (state)
			3'b000: begin // A
				if (w)
					next_state = 3'b000; // Stay in A
				else
					next_state = 3'b001; // Go to B
			end
			
			3'b001: begin // B
				if (w)
					next_state = 3'b010; // Go to C
				else
					next_state = 3'b011; // Go to D
			end
			
			3'b010: begin // C
				if (w)
					next_state = 3'b101; // Go to F
				else
					next_state = 3'b110; // Go to E
			end
			
			3'b011: begin // D
				if (w)
					next_state = 3'b110; // Go to E
				else
					next_state = 3'b000; // Go to A
			end
			
			3'b100: begin // E
				if (w)
					next_state = 3'b100; // Stay in E
				else
					next_state = 3'b011; // Go to D
			end
			
			3'b101: begin // F
				if (w)
					next_state = 3'b010; // Go to C
				else
					next_state = 3'b011; // Go to D
			end
			
			default: next_state = 3'b000; // Default state is A
		endcase
	end

	assign z = (state == 3'b101 || state == 3'b100) ? 1 : 0;
	
	initial begin
		$display("Simulation started");
		$dumpfile("wave.vcd");
		$dumpvars(0, top_module);
		clk = 0;
		reset = 1;
		#10 reset = 0;
		#10 reset = 1;
		#10 reset = 0;
		#25 w = 0;
		#25 w = 1;
		#25 w = 0;
		#25 w = 1;
		#25 w = 0;
		#975 w = 1;
		#10;
		$display("Simulation finished");
		$finish;
	end
	
	integer i;
	
	always @(posedge clk) begin
		if (i < 200) begin
			i = i + 1;
			#5;
		end
		else begin
			$display("Mismatches: %d in 200 samples", mismatch_count);
			$finish;
		end
	end

endmodule
