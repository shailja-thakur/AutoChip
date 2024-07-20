module top_module (
    input clock,
    input a, 
    output reg p,
    output reg q
);
    
    // Using a sequential always block to model the sequential behavior of the circuit
    always @(posedge clock) begin
        if (a) begin
            p <= 1;
        end
        else begin
            p <= 0;
        end

        // The 'q' signal imitates the 'p' signal but is delayed by one clock cycle
        q <= p;
    end
    
endmodule
