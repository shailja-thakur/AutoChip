module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);
    // State encoding
    typedef enum logic [0:0] {
        OFF = 1'b0,
        ON = 1'b1
    } state_t;
    
    state_t state, next_state;
    
    // State transition logic (Moore state machine)
    always_ff @(posedge clk) begin
        if (reset)
            state <= OFF;
        else
            state <= next_state;
    end

    // Next state logic
    always_comb begin
        case (state)
            OFF: next_state = j ? ON : OFF;
            ON:  next_state = k ? OFF : ON;
            default: next_state = OFF;
        endcase
    end
    
    // Output logic
    always_ff @(posedge clk) begin
        if (reset)
            out <= 1'b0;
        else
            out <= (state == ON);
    end
endmodule
