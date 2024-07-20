module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

    typedef enum logic [1:0] {S, S1, S10} state_t;
    state_t state, next_state;
    
    // State transition logic
    always @(*) begin
        case (state)
            S: next_state = x ? S1 : S;
            S1: next_state = x ? S1 : S10;
            S10: next_state = x ? S1 : S;
            default: next_state = S;
        endcase
    end
    
    // State register logic with asynchronous reset
    always @(posedge clk or negedge aresetn) begin
        if (!aresetn)
            state <= S;
        else
            state <= next_state;
    end
    
    // Output logic
    always @(*) begin
        case (state)
            S: z = 0;
            S1: z = 0;
            S10: z = x;
            default: z = 0;
        endcase
    end

endmodule
