module top_module(
	input clk,
	input d,
	output reg q);
	
	reg qp;
	reg qn;
	reg prev_clk;

	always @(posedge clk) begin
		qp <= d;
		prev_clk <= 1;
	end
	
	always @(negedge clk) begin
		qn <= d;
		prev_clk <= 0;
	end
	
	always @(posedge clk or negedge clk) begin
		if (prev_clk)
			q <= qp;
		else
			q <= qn;
	end
	
	initial begin
		// Reset all signals
		clk <= 0;
		d <= 0;
		q <= 0;

		#10; // Delay for 10 time units

		// Apply test pattern
		clk <= 1;
		d <= 1;
		
		#5; // Delay for 5 time units
		
		// Apply test pattern
		d <= 0;
		
		#10; // Delay for 10 time units
		
		$finish;
	end
	
endmodule
