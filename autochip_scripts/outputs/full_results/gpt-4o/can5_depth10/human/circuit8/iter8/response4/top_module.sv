module top_module (
    input clock,
    input a, 
    output reg p,
    output reg q
);

    reg state;
    
    always @(posedge clock) begin
        // Update p at the positive edge of the clock
        if (a) begin
            state <= 1;
        end else begin
            state <= 0;
        end
        p <= state;
    end
    
    always @(negedge clock) begin
        // Update q at the negative edge of the clock
        q <= state;
    end
endmodule
