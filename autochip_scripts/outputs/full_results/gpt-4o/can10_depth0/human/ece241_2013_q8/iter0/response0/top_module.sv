module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

    // State definitions
    typedef enum reg [1:0] {
        S0, // Initial state
        S1, // State after seeing '1'
        S2  // State after seeing '10'
    } state_t;
    
    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            S0: begin
                if (x)
                    next_state = S1;
                else
                    next_state = S0;
            end
            
            S1: begin
                if (x)
                    next_state = S1;
                else
                    next_state = S2;
            end
            
            S2: begin
                if (x)
                    next_state = S1;
                else
                    next_state = S0;
            end
            
            default: next_state = S0;
        endcase
    end

    // State flip-flops with asynchronous reset
    always @(negedge aresetn or posedge clk) begin
        if (!aresetn)
            state <= S0;
        else
            state <= next_state;
    end

    // Output logic
    always @(*) begin
        z = (state == S2 && x) ? 1'b1 : 1'b0;
    end

endmodule
