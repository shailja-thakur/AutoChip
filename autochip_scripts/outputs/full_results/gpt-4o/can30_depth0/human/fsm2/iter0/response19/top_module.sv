module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);
    // State declaration
    typedef enum logic [1:0] {
        OFF = 1'b0,
        ON = 1'b1
    } state_t;
    
    // State register
    state_t state, next_state;
    
    // Output logic (Moore): set output based on the current state
    always @(posedge clk, posedge areset) begin
        if (areset) begin
            state <= OFF;
        end else begin
            state <= next_state;
        end
    end
    
    // State transition logic (Next state logic)
    always @(*) begin
        case (state)
            OFF: if (j) next_state = ON;
                 else next_state = OFF;
            ON: if (k) next_state = OFF;
                else next_state = ON;
            default: next_state = OFF; // Should never reach here
        endcase
    end
    
    // Output logic
    always @(*) begin
        case (state)
            OFF: out = 1'b0;
            ON: out = 1'b1;
            default: out = 1'b0; // Default to safe value
        endcase
    end
    
endmodule
