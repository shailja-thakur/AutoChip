module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

    typedef enum logic [1:0] {
        S0 = 2'b00, // initial state
        S1 = 2'b01, // state after seeing 1
        S2 = 2'b10  // state after seeing 10
    } state_t;
    
    state_t state, next_state;

    // State transition
    always_ff @(posedge clk or negedge aresetn) begin
        if (!aresetn)
            state <= S0;
        else
            state <= next_state;
    end

    // Next state logic
    always_comb begin
        case (state)
            S0: 
                if (x)
                    next_state = S1;
                else
                    next_state = S0;
            S1: 
                if (x)
                    next_state = S1;
                else
                    next_state = S2;
            S2: 
                if (x)
                    next_state = S1;
                else
                    next_state = S0;
            default: 
                next_state = S0;
        endcase
    end

    // Output logic
    always_ff @(posedge clk or negedge aresetn) begin
        if (!aresetn)
            z <= 0;
        else
            z <= (state == S2 && x);
    end

endmodule
