module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

    // State Encoding
    parameter OFF = 1'b0, ON = 1'b1;
    reg state, next_state;

    // State transition logic
    always @(*) begin
        case(state)
            OFF: next_state = j ? ON : OFF;
            ON:  next_state = k ? OFF : ON;
            default: next_state = OFF;
        endcase
    end

    // State register with synchronous reset
    always @(posedge clk) begin
        if (reset)
            state <= OFF;
        else
            state <= next_state;
    end

    // Output logic
    always @(posedge clk) begin
        if (reset)
            out <= 1'b0;
        else
            out <= (state == ON) ? 1'b1 : 1'b0;
    end
endmodule
