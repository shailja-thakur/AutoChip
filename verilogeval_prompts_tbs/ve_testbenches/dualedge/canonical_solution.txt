	
	/*always @(posedge clk, negedge clk) begin
		q <= d;
	end*/

	reg qp, qn;
    always @(posedge clk)
        qp <= d;
    always @(negedge clk)
        qn <= d;
    // assign q = clk ? qp : qn;  // This causes q to change too early when clk changes. Need delay by delta cycle
    always @(*)
        q <= clk ? qp : qn;
endmodule
