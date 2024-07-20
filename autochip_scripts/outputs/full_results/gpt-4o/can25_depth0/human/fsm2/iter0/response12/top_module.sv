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
    
    // State and next state variables
    state_t state, next_state;
    
    // Asynchronous reset and state transition logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            state <= OFF;
        else
            state <= next_state;
    end
    
    // Next state logic
    always_comb begin
        case (state)
            OFF: next_state = j ? ON : OFF;
            ON: next_state = k ? OFF : ON;
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
