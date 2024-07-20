module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

    // State declaration
    typedef enum logic [0:0] {
        OFF = 1'b0, 
        ON = 1'b1
    } state_t;
    
    state_t state, next_state;

    // State transition
    always_comb begin
        case (state)
            OFF: if (j) next_state = ON; else next_state = OFF;
            ON: if (k) next_state = OFF; else next_state = ON;
            default: next_state = OFF;
        endcase
    end

    // State flip-flops with asynchronous reset
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            state <= OFF;
        else
            state <= next_state;
    end

    // Output logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            out <= 1'b0;
        else if (state == OFF)
            out <= 1'b0;
        else
            out <= 1'b1;
    end

endmodule
