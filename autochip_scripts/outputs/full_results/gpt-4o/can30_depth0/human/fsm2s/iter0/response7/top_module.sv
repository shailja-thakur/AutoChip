module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);
    // State encoding
    typedef enum reg {
        OFF = 1'b0,
        ON  = 1'b1
    } state_t;
    
    state_t state, next_state;
    
    // State transition logic
    always @(*) begin
        case(state)
            OFF: next_state = (j) ? ON : OFF;
            ON:  next_state = (k) ? OFF : ON;
            default: next_state = OFF;
        endcase
    end
    
    // State flip-flops with synchronous reset
    always @(posedge clk) begin
        if (reset) state <= OFF;
        else state <= next_state;
    end
    
    // Output logic
    always @(state) begin
        out = (state == ON);
    end
endmodule
