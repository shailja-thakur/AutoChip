module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // Define the states
    parameter A = 0, B = 1;
    
    // State register
    reg state, next_state;
    
    // Combinational logic to determine next state
    always @(*) begin
        case (state)
            A: begin
                if (in)
                    next_state = A;
                else
                    next_state = B;
            end
            B: begin
                if (in)
                    next_state = B;
                else
                    next_state = A;
            end
            default: next_state = A; // Default to state A
        endcase
    end

    // Sequential logic to update state on rising edge of clock
    always @(posedge clk) begin
        if (reset)
            state <= B; // Reset to state B
        else
            state <= next_state; // Update state to next_state
    end

    // Output logic
    always @(state) begin
        if (state == B)
            out = 1;
        else
            out = 0;
    end

endmodule
