module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output out
);
    
    // State encoding
    typedef enum logic [0:0] {
        OFF = 1'b0,
        ON  = 1'b1
    } state_t;

    // State variable
    state_t state, next_state;

    // Output logic
    assign out = (state == ON);

    // Next state logic
    always_comb begin
        case (state)
            OFF: if (j) next_state = ON;
                 else next_state = OFF;
            ON : if (k) next_state = OFF;
                 else next_state = ON;
        endcase
    end

    // State transition (sequential logic)
    always_ff @(posedge clk) begin
        if (reset)
            state <= OFF;
        else
            state <= next_state;
    end
    
endmodule
