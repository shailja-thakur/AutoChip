module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

    typedef enum logic [0:0] {OFF=0, ON=1} state_t;
    state_t state, next_state;
    
    // State transition logic
    always @(*) begin
        case(state)
            OFF: begin
                if (j)
                    next_state = ON;
                else
                    next_state = OFF;
            end
            ON: begin
                if (k)
                    next_state = OFF;
                else
                    next_state = ON;
            end
            default: next_state = OFF;
        endcase
    end
    
    // State register (synchronous reset)
    always @(posedge clk) begin
        if (reset)
            state <= OFF;
        else
            state <= next_state;
    end
    
    // Output logic
    always @(posedge clk) begin
        if (reset)
            out <= 0;
        else
            out <= state;
    end
endmodule
