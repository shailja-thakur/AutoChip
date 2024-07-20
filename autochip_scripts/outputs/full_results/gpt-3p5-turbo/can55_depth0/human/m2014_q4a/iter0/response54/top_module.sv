module top_module (
	input d,
	input ena,
	output logic q
);
	always @ (posedge ena)
    	if (ena)
        	q <= d;
    	else
        	q <= q;
endmodule
