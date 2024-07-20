module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

    // State encoding
    parameter OFF = 1'b0, ON = 1'b1;
    reg state, next_state;

    // State transition
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
            default: next_state = OFF;  // Default state
        endcase
    end

    // Synchronous state update
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
