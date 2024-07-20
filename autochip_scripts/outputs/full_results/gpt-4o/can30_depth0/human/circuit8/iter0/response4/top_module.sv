module top_module (
	input clock,
	input a, 
	output reg p,
	output reg q
);
    
    // Internal register to hold state for q
    reg state_q;

    // Sequential logic
    always @(posedge clock) begin
        if (a) begin
            p <= 1;
        end else begin
            p <= 0;
        end
    end
    
    always @(negedge clock) begin
        state_q <= p;
    end

    always @(posedge clock) begin
        q <= state_q;
    end

endmodule
