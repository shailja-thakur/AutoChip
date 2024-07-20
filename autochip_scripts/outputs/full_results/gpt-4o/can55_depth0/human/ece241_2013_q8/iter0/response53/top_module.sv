module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

    typedef enum logic [1:0] {
        S0, // Initial state
        S1, // First '1' detected
        S2  // '10' detected
    } state_t;
    
    state_t state, next_state;

    // Next state logic (combinational)
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

    // State flip-flops (sequential)
    always @(negedge clk or negedge aresetn) begin
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
            S2: z = x; // Output 'z' is high when sequence "101" is detected
            default: z = 0;
        endcase
    end

endmodule
