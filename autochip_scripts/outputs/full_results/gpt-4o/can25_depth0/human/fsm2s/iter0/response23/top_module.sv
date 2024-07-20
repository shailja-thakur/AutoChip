module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output out
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

    // Next state logic
    always_comb begin
        case (state)
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

    // Output logic
    assign out = (state == ON) ? 1'b1 : 1'b0;

endmodule
