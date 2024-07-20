module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);
    // State encoding
    typedef enum logic [1:0] {
        OFF = 2'b00,
        ON  = 2'b01
    } state_t;
    
    state_t state, next_state;
    
    // State transition logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
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
            default: next_state = OFF;
        endcase
    end
    
    // Output logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            out <= 0;
        else
            out <= (state == ON);
    end
endmodule
