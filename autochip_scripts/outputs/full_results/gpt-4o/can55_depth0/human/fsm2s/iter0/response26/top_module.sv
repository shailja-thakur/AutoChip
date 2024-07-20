module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

    // State Definitions
    typedef enum logic {
        OFF = 1'b0,
        ON  = 1'b1
    } state_t;

    state_t state, next_state;

    // State Transition Logic
    always @(*) begin
        case (state)
            OFF: begin
                if (j == 1)
                    next_state = ON;
                else
                    next_state = OFF;
            end
            ON: begin
                if (k == 1)
                    next_state = OFF;
                else
                    next_state = ON;
            end
            default: next_state = OFF;
        endcase
    end

    // State Flip-Flops with Synchronous Reset
    always @(posedge clk) begin
        if (reset)
            state <= OFF;
        else
            state <= next_state;
    end

    // Output Logic
    always @(posedge clk) begin
        if (reset)
            out <= 1'b0;
        else
            out <= (state == ON);
    end

endmodule
