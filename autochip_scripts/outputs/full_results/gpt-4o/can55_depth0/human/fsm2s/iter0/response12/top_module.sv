module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

    // State encoding
    typedef enum logic [1:0] {
        OFF = 1'b0,
        ON = 1'b1
    } state_t;

    state_t state, next_state;

    // State transition
    always_ff @(posedge clk) begin
        if (reset)
            state <= OFF;
        else
            state <= next_state;
    end

    // Next state logic
    always_comb begin
        case (state)
            OFF: if (j) 
                    next_state = ON;
                 else 
                    next_state = OFF;
            
            ON: if (k) 
                   next_state = OFF;
                else 
                   next_state = ON;
        endcase
    end

    // Output logic
    always_comb begin
        case (state)
            OFF: out = 1'b0;
            ON:  out = 1'b1;
        endcase
    end

endmodule
