module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    typedef enum logic [0:0] {
        S_A = 1'b0,  // State A
        S_B = 1'b1   // State B
    } state_t;
    
    state_t state, next_state;
    
    // State transition
    always_ff @(posedge clk) begin
        if (reset) 
            state <= S_B;
        else 
            state <= next_state;
    end

    // Next state logic
    always_comb begin
        case (state)
            S_A: if (in) 
                    next_state = S_A;
                 else 
                    next_state = S_B;
            S_B: if (in) 
                    next_state = S_B;
                 else 
                    next_state = S_A;
            default: next_state = S_B;
        endcase
    end

    // Output logic
    always_ff @(posedge clk) begin
        if (reset)
            out <= 1'b1;
        else begin
            case (state)
                S_A: out <= 1'b0;
                S_B: out <= 1'b1;
            endcase
        end
    end

endmodule
