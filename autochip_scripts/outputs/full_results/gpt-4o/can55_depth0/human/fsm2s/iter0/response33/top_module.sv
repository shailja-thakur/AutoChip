module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

    // State encoding
    typedef enum logic [1:0] {
        OFF = 2'b00,
        ON  = 2'b01
    } state_t;

    state_t state, next_state;
    
    // State transition
    always_ff @(posedge clk) begin
        if (reset)
            state <= OFF;
        else
            state <= next_state;
    end
    
    // Next state logic and output logic
    always_comb begin
        case (state)
            OFF: begin
                out = 0;
                if (j)
                    next_state = ON;
                else
                    next_state = OFF;
            end
            ON: begin
                out = 1;
                if (k)
                    next_state = OFF;
                else
                    next_state = ON;
            end
            default: begin
                out = 0;
                next_state = OFF;
            end
        endcase
    end
    
endmodule
