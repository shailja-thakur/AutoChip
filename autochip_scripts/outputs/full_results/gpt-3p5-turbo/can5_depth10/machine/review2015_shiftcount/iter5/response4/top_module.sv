module top_module(
	input clk,
	input shift_ena,
	input count_ena,
	input data,
	output reg [3:0] q
);

	always @(posedge clk) begin
		if (shift_ena) begin
			q <= data;
		end
		else if (count_ena) begin
			q <= q - 1;
		end
		else begin
			q <= q;
		end
	end

endmodule
module top_module_tb();
	reg clk;
	reg shift_ena;
	reg count_ena;
	reg data;
	wire [3:0] q;

	// Instantiate the module to be tested
	top_module dut(
		.clk(clk),
		.shift_ena(shift_ena),
		.count_ena(count_ena),
		.data(data),
		.q(q)
	);

	// Initialize the inputs
	initial begin
		clk = 0;
		shift_ena = 0;
		count_ena = 0;
		data = 0;
    
        // Add your test vectors here to simulate different scenarios
        // Example test vectors:
        // #10 shift_ena = 1; data = 4; // expect q = 4
        // #10 count_ena = 1; // expect q = 3
        // #10 count_ena = 1; // expect q = 2
        // #10 shift_ena = 1; data = 7; // expect q = 7
    
		#5;
		clk = 1;
		#5;
		clk = 0;
		#5;
		clk = 1;
		#5;
		clk = 0;
		#5;
		clk = 1;
		#5;
		clk = 0;
		#5;
		clk = 1;
		#5;
		clk = 0;
		#5;
		clk = 1;
		#5;
		clk = 0;
		#5;
		clk = 1;
		#5;
		clk = 0;
		#5;
		clk = 1;
		#5;
		clk = 0;
		#5;
		clk = 1;
		#5;
		clk = 0;
		#5;
		clk = 1;
		#5;
		clk = 0;
		#5;
		clk = 1;
		#5;
		clk = 0;
    
		$finish;
	end

	// Toggle clock
	always #5 clk = ~clk;

endmodule
