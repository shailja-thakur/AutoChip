module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);
    // State declaration
    typedef enum reg [1:0] {
        S,    // State 0
        S1,   // State 1
        S10   // State 2
    } state_t;
    
    state_t state, next_state;
    
    // State transition logic
    always @(*) begin
        case (state)
            S: begin
                if (x == 0)
                    next_state = S;
                else
                    next_state = S1;
            end
            S1: begin
                if (x == 0)
                    next_state = S10;
                else
                    next_state = S1;
            end
            S10: begin
                if (x == 0)
                    next_state = S;
                else
                    next_state = S1;
            end
            default: next_state = S;
        endcase
    end

    // State register
    always @(posedge clk or negedge aresetn) begin
        if (!aresetn)
            state <= S; // Reset state
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
