module top_module (
    input clock,
    input a,
    output reg p,
    output reg q
);

    always @(posedge clock or negedge clock) begin
        if (!clock) begin
            q <= p; // Update q to previous value of p on negative edge of clock
        end
        else begin
            p <= a; // Update p with value of a on positive edge of clock
        end
    end
    
endmodule
