module top_module (
	input a,
	input b,
	input sel,
	output out
);

    // The output should be the selected input based on the sel signal
    assign out = sel ? b : a;
    
endmodule
