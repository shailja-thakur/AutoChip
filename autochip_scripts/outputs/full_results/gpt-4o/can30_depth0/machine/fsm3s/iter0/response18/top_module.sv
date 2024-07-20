module top_module (
    input clk,
    input in,
    input reset,
    output out
);

    // State declaration
    typedef enum logic [1:0] {A, B, C, D} state_t;
    state_t state, next_state;

    // Output logic
    assign out = (state == D);

    // State transition
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            state <= A;
        else
            state <= next_state;
    end

    // Next state logic
    always_comb begin
        case (state)
            A: 
                if (in)
                    next_state = B;
                else
                    next_state = A;
            B: 
                if (in)
                    next_state = B;
                else
                    next_state = C;
            C: 
                if (in)
                    next_state = D;
                else
                    next_state = A;
            D: 
                if (in)
                    next_state = B;
                else
                    next_state = C;
            default: 
                next_state = A; // Default to initial state
        endcase
    end
endmodule
