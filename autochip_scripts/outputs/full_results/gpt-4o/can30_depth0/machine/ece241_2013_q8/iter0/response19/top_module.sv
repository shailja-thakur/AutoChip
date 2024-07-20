module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

    typedef enum reg [1:0] {S, S1, S10} state_t;
    state_t state, next_state;

    // Synchronous process: state transition on clock and reset
    always @(posedge clk or negedge aresetn) begin
        if (!aresetn)
            state <= S;
        else
            state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case (state)
            S: 
                if (x) 
                    next_state = S1;
                else 
                    next_state = S;
            S1: 
                if (x)
                    next_state = S1;
                else
                    next_state = S10;
            S10: 
                if (x)
                    next_state = S1;
                else
                    next_state = S;
            default: 
                next_state = S; // Default state
        endcase
    end

    // Output logic
    always @(*) begin
        case (state)
            S: z = 0;
            S1: z = 0;
            S10: z = x; // Output is the current input x
            default: z = 0;
        endcase
    end

endmodule
