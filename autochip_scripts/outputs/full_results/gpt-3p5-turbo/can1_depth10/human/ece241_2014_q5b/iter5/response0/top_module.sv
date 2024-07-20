module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

	// Declare states
	reg [1:0] current_state, next_state;
	parameter A = 2'b00;
	parameter B = 2'b01;
	
	// State transition logic
	always @(posedge clk or posedge areset) begin
		if (areset)
			current_state <= A;
		else
			current_state <= next_state;
	end
	
	// Output logic
	always @(current_state, x) begin
		next_state = current_state;
		case (current_state)
			A: begin
				if (x)
					next_state = B;
			end
			B: begin
				if (!x)
					next_state = A;
			end
		endcase
		
		case (next_state)
			A: z = 1'b0;
			B: z = 1'b1;
		endcase
	end
endmodule
module top_tb();
	reg clk, areset, x;
	wire z;
	
	top_module dut (
		.clk(clk),
		.areset(areset),
		.x(x),
		.z(z)
	);
	
	always begin
		#5 clk = ~clk;
	end
	
	initial begin
		clk = 0;
		areset = 1;
		x = 0;
		#10 areset = 0;
		#10 x = 1;
		#10 x = 0;
		#10 x = 1;
		#10 x = 0;
		#10 x = 1;
		#10 x = 0;
		#10 x = 1;
		#10 $finish;
	end
	
	initial begin
		$dumpfile("wave.vcd");
		$dumpvars(0, top_module);
		$monitor($time, " z = %b", z);
	end
	
endmodule
