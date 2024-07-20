module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);
    typedef enum reg {OFF, ON} state_t;
    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            OFF: next_state = j ? ON : OFF;
            ON: next_state = k ? OFF : ON;
            default: next_state = OFF;
        endcase
    end

    // State register logic with synchronous reset
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
        else begin
            case (state)
                OFF: out <= 0;
                ON: out <= 1;
                default: out <= 0;
            endcase
        end
    end

endmodule
