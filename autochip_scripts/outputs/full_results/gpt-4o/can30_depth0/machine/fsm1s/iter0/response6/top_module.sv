module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // State encoding
    parameter A = 1'b0, B = 1'b1;
    
    // State register
    reg state, next_state;

    // Combinational logic block for next state logic
    always @(*) begin
        case (state)
            A: if (in) 
                   next_state = A;
               else 
                   next_state = B;
            B: if (in) 
                   next_state = B;
               else 
                   next_state = A;
            default: next_state = B;  // Default state for safety
        endcase
    end

    // Sequential logic block for state transitions, triggered on clk's rising edge
    always @(posedge clk or posedge reset) begin
        if (reset) 
            state <= B; // State reset
        else 
            state <= next_state;
    end

    // Output logic
    always @(state) begin
        out = (state == B);
    end

endmodule
