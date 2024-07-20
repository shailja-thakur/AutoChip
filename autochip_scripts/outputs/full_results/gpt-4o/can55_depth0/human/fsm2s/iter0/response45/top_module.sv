module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);
    // State encoding
    typedef enum reg {OFF = 1'b0, ON = 1'b1} state_t;
    state_t state, next_state;
    
    // State transition logic (combinational logic)
    always @(*) begin
        case(state)
            OFF: 
                if (j)
                    next_state = ON;
                else
                    next_state = OFF;
            ON: 
                if (k)
                    next_state = OFF;
                else
                    next_state = ON;
            default:
                next_state = OFF;
        endcase
    end

    // State flip-flops with synchronous reset (sequential logic)
    always @(posedge clk) begin
        if (reset)
            state <= OFF;
        else
            state <= next_state;
    end
    
    // Output logic based on state (Moore machine)
    always @(posedge clk) begin
        if (state == OFF)
            out <= 1'b0;
        else
            out <= 1'b1;
    end
endmodule
