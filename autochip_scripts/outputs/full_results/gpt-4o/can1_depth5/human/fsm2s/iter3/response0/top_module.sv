module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

    // State encoding
    localparam OFF = 1'b0;
    localparam ON  = 1'b1;

    // State register
    reg state, next_state;

    // State transition logic
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

    // State flip-flops with synchronous reset
    always @(posedge clk) begin
        if (reset)
            state <= OFF;
        else
            state <= next_state;
    end

    // Output logic based on state
    always @(posedge clk) begin
        if (state == ON)
            out <= 1'b1;
        else
            out <= 1'b0;
    end

endmodule
