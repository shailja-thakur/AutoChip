module top_module (
    input a,
    input b,
    input c,
    input d,
    output q
);
	
    // Implementation of the OR gate
    assign q = b | c;
	
endmodule
