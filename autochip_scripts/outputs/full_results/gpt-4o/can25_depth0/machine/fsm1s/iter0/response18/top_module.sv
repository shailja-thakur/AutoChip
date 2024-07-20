module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // Define state parameters
    parameter A = 1'b0, B = 1'b1;
    
    // Register to hold the current state
    reg state, next_state;

    // Combinational logic block to determine next state
    always @(*) begin
        case(state)
            A: 
                if (in)
                    next_state = A;
                else
                    next_state = B;
            B:
                if (in)
                    next_state = B;
                else
                    next_state = A;
            default:
                next_state = A; // Default to state A
        endcase
    end
    
    // Sequential logic block to update state on rising edge of clk or reset
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= B; // Reset to state B
        else
            state <= next_state; // Update state
    end

    // Output logic based on current state
    always @(state) begin
        if (state == B)
            out = 1'b1;
        else
            out = 1'b0;
    end
endmodule
