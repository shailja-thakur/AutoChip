module top_module (
	input a,
	input b,
	input sel,
	output out
);

	always @(*) begin
    	if (sel == 1'b1)
        	out = b;
    	else if (sel == 1'b0)
        	out = a;
    end
    
endmodule
