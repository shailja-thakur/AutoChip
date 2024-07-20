module top_module (
	input clk,
	input d,
	input r,
	output logic q
);
	
    reg q;
    
    always @(posedge clk) begin
        if (r)
            q <= 0;
        else
            q <= d;
    end
    
endmodule
