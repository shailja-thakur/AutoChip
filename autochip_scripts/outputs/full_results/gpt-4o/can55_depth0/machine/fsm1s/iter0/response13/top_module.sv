module top_module (
    input clk,
    input in,
    input reset,
    output out
);

    // Define state parameters
    parameter A = 1'b0, B = 1'b1;

    // State register
    reg state, next_state;

    // Combinational logic block to determine the next state
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
            default: next_state = B; // Default to state B
        endcase
    end

    // Sequential logic block triggered by the clock edge
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= B; // Reset to initial state B
        else
            state <= next_state; // Update state
    end

    // Output logic
    assign out = (state == B);

endmodule
