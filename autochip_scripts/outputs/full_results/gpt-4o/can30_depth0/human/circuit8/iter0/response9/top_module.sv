module top_module (
    input clock,
    input a, 
    output reg p,
    output reg q
);
    
    // Using a reg to store the previous state of a for comparison
    reg prev_a;
    
    initial begin
        p = 0;
        q = 0;
        prev_a = 0;
    end

    always @(posedge clock) begin
        prev_a <= a;            // Store the current state of 'a' for next clock cycle
    
        if (a && !prev_a)       // 'a' is rising edge detected
            p <= 1;
        else if (!a && prev_a)  // 'a' is falling edge detected
            p <= 0;
            
        if (p)
            q <= 1;
        else
            q <= 0;
    end
    
    always @(negedge clock) begin
        prev_a <= a;            // Update prev_a on negedge as well to maintain consistency
    end
    
endmodule
