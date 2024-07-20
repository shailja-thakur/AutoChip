module top_module (
	input wire clock,
	input wire a, 
	output reg p,
	output reg q
);
    // Register q is assigned the value of signal a at the negative edge of the clock
    always @(negedge clock) begin
        q <= a;
    end
    
    // Register p is assigned the value of signal a when it changes, but only if clock is high
    always @(posedge clock or a) begin
        if (clock) begin
            p <= a;
        end
    end

endmodule
