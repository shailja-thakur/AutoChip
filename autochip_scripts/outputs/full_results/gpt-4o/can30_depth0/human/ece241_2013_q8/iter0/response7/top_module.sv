module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

    // State encoding
    typedef enum logic [1:0] {
        S0 = 2'b00,   // Initial state
        S1 = 2'b01,   // State after seeing '1'
        S2 = 2'b10    // State after seeing '10'
    } state_t;
    
    state_t state, next_state;

    // State transition logic (combinational)
    always @(*) begin
        case (state)
            S0: begin
                if (x)
                    next_state = S1;
                else
                    next_state = S0;
                z = 1'b0;
            end
            S1: begin
                if (!x)
                    next_state = S2;
                else
                    next_state = S1;
                z = 1'b0;
            end
            S2: begin
                if (x)
                    next_state = S1;
                else
                    next_state = S0;
                z = x;
            end
            default: begin
                next_state = S0;
                z = 1'b0;
            end
        endcase
    end

    // State flip-flops with asynchronous reset (sequential)
    always @(negedge aresetn or posedge clk) begin
        if (!aresetn)
            state <= S0;
        else
            state <= next_state;
    end

endmodule
