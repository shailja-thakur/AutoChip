module top_module (
    input clk,
    input in,
    input reset,
    output out
);
    
    reg current_state, next_state;
    wire clear;
    
    initial begin
        current_state = 1'b1; // Starting with state B
        out = 1'b1; // Output is 1 in state B
    end
    
    always @(posedge clk, posedge reset) begin
        if (reset)
            current_state <= 1'b1; // Resetting to state B
        else
            current_state <= next_state; // Updating the current state
    end
    
    always @* begin
        case (current_state)
            1'b0:
                if (in)
                    next_state = 1'b0; // Transition from state A to A
                else
                    next_state = 1'b1; // Transition from state A to B
            1'b1:
                if (in)
                    next_state = 1'b1; // Transition from state B to B
                else
                    next_state = 1'b0; // Transition from state B to A
        endcase
    end
    
    assign clear = reset && ~in; // Combining reset and input for clear logic
    
    always @(posedge clk or posedge reset) begin
        if (reset)
            out <= 1'b1; // Output is 1 during reset
        else if (clear)
            out <= 1'b1; // Output is 1 during clear condition
        else
            out <= current_state; // Output is same as current state
    end
    
endmodule
