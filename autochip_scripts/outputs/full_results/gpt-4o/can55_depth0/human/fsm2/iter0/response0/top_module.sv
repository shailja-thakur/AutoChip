module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

    typedef enum logic [0:0] {OFF=0, ON=1} state_t;
    state_t state, next_state;

    // State transition logic (combinational)
    always_comb begin
        case (state)
            OFF: next_state = j ? ON : OFF;
            ON: next_state = k ? OFF : ON;
        endcase
    end

    // State flip-flops with asynchronous reset
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            state <= OFF;
        else
            state <= next_state;
    end

    // Output logic (combinational)
    always_comb begin
        case (state)
            OFF: out = 0;
            ON: out = 1;
        endcase
    end

endmodule
