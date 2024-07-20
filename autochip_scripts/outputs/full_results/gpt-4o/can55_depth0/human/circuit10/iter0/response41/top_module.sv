module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output state
);
    reg ff; // flip-flop to store state
    
    // Assign the flip-flop output to the state
    assign state = ff;
    
    // Always block to manage state transitions on the clock's rising edge
    always @(posedge clk) begin
        if (a & b)
            ff <= ~ff; // Toggle state when both a and b are 1
        else if (a & !b)
            ff <= ff; // Maintain state when a is 1 and b is 0
        else if (!a & b)
            ff <= 1'b0; // Set state to 0 when a is 0 and b is 1
        else
            ff <= 1'b1; // Set state to 1 when both a and b are 0
        
        q <= ff;
    end
endmodule
