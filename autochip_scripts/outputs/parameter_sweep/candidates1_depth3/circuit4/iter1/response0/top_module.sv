module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

	// Define internal wire signals
	wire w1, w2, w3;

	// Implement the combinational circuit logic
	assign w1 = a & b;
	assign w2 = c & d;
	assign w3 = w1 | w2;
	assign q = ~w3;

	// Add initial block to initialize inputs
	initial begin
		// Initialize inputs
		a = 0;
		b = 0;
		c = 0;
		d = 0;

		// Wait before changing inputs for first time
		#5;

		// Change inputs according to waveform
		#5 a = 0; b = 0; c = 0; d = 1;
		#5 a = 0; b = 0; c = 1; d = 0;
		#5 a = 0; b = 0; c = 1; d = 1;
		#5 a = 0; b = 1; c = 0; d = 0;
		#5 a = 0; b = 1; c = 0; d = 1;
		#5 a = 0; b = 1; c = 1; d = 0;
		#5 a = 0; b = 1; c = 1; d = 1;
		#5 a = 1; b = 0; c = 0; d = 0;
		#5 a = 1; b = 0; c = 0; d = 1;
		#5 a = 1; b = 0; c = 1; d = 0;
		#5 a = 1; b = 0; c = 1; d = 1;
		#5 a = 1; b = 1; c = 0; d = 0;
		#5 a = 1; b = 1; c = 0; d = 1;
		#5 a = 1; b = 1; c = 1; d = 0;
		#5 a = 1; b = 1; c = 1; d = 1;

		// Finish simulation
		$finish;
	end

endmodule
