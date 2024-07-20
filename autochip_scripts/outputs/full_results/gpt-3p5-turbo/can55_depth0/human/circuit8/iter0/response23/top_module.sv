module top_module (
	input clock,
	input a, 
	output reg p,
	output reg q
);
    
    reg p_temp, q_temp;
    
    always @(posedge clock) begin
        p_temp <= a;
        q_temp <= p_temp;
        
        if (a && p_temp && q_temp)
            p <= 1'b1;
        else
            p <= 1'b0;
        
        if (a || p_temp || q_temp)
            q <= 1'b1;
        else
            q <= 1'b0;
    end

endmodule
