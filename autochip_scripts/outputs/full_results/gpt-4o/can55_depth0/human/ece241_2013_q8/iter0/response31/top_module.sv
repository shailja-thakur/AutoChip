module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

    // State encoding
    typedef enum logic [1:0] {
        S0,  // Initial state
        S1,  // Saw first '1'
        S2   // Saw '10'
    } state_t;
    
    state_t state, next_state;
    
    // State transition logic (combinational)
    always @(*) begin
        case (state)
            S0: if (x) next_state = S1; else next_state = S0;
            S1: if (x) next_state = S1; else next_state = S2;
            S2: if (x) next_state = S1; else next_state = S0;
            default: next_state = S0;
        endcase
    end

    // State flip-flops with asynchronous reset (sequential)
    always @(negedge aresetn or posedge clk) begin
        if (!aresetn)
            state <= S0;
        else
            state <= next_state;
    end

    // Output logic (combinational)
    always @(*) begin
        case (state)
            S0: z = 0;
            S1: z = 0;
            S2: z = x ? 1 : 0;
            default: z = 0;
        endcase
    end

endmodule
