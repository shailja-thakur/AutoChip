module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

    // State encoding
    typedef enum logic [1:0] {
        S0 = 2'b00, // Initial state
        S1 = 2'b01, // State after receiving '1'
        S2 = 2'b10  // State after receiving '10'
    } state_t;
    
    state_t state, next_state;

    always_ff @(negedge aresetn or posedge clk) begin
        if (!aresetn)
            state <= S0;
        else
            state <= next_state;
    end

    always_ff @(posedge clk) begin
        case (state)
            S0: next_state = x ? S1 : S0; // If x is '1' go to S1, otherwise stay in S0
            S1: next_state = x ? S1 : S2; // If x is '1' stay in S1, if x is '0' go to S2
            S2: next_state = x ? S1 : S0; // If x is '1' go to S1, if x is '0' go to S0
            default: next_state = S0;
        endcase
    end

    always_ff @(posedge clk) begin
        case (state)
            S0: z = 0;
            S1: z = 0;
            S2: z = x ? 1 : 0; // If the state is S2 and x is '1', set z to 1 (sequence "101" detected), otherwise 0
            default: z = 0;
        endcase
    end

endmodule
