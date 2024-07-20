module top_module (
    input clock,
    input a, 
    output reg p,
    output reg q
);

    // First always block: updates q on the negative edge of the clock
    always @(negedge clock) begin
        q <= a;
    end
    
    // Second always block: updates p on any change of a
    always @(a) begin
        if (clock) begin
            p <= a;
        end
    end

endmodule
