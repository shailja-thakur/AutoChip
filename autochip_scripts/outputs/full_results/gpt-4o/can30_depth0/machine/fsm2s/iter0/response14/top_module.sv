module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);
    // Define the states as parameters
    parameter A = 1'b0, B = 1'b1;
    
    // Declare state register
    reg state, next_state;
    
    // Sequential logic for state transitions
    always @ (posedge clk or posedge reset) begin
        if (reset)
            state <= A;
        else
            state <= next_state;
    end
    
    // Combinational logic for next state and output
    always @ (*) begin
        case (state)
            A: begin
                if (j)
                    next_state = B;
                else
                    next_state = A;
            end
            B: begin
                if (k)
                    next_state = A;
                else
                    next_state = B;
            end
            default: next_state = A;
        endcase
        
        // Output logic
        out = (state == B) ? 1'b1 : 1'b0;
    end
endmodule
