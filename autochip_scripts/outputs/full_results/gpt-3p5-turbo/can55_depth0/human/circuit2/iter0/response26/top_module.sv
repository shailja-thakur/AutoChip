module top_module (
    input a,
    input b,
    input c,
    input d,
    output q
);
	
	// assign the output q based on the given simulation waveforms
	assign q = ((!a && !b && !c && !d) || (!a && !b && !c && d) || (!a && !b && c && d) || (!a && b && !c && !d) || (!a && b && c && d) || (a && !b && !c && d) || (a && !b && c && d) || (a && b && c && !d));
	
endmodule
