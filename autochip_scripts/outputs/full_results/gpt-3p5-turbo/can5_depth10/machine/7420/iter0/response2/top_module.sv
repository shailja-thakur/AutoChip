module top_module(
    input p1a, 
    input p1b, 
    input p1c, 
    input p1d, 
    output p1y, 
    input p2a, 
    input p2b, 
    input p2c, 
    input p2d, 
    output p2y
);

	//  AND gate for p1y output
	and gate1(p1a, p1b, p1c, p1d, p1y);

	//  AND gate for p2y output
    and gate2(p2a, p2b, p2c, p2d, p2y);

endmodule
module and(
    input a, 
    input b, 
    input c, 
    input d, 
    output y
);
	assign y = ~(&a & b & c & d);
endmodule
