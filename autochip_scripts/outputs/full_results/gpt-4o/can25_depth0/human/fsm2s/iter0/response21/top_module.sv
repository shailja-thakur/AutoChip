module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

    reg state, next_state;

    // State encoding
    localparam OFF = 1'b0;
    localparam ON = 1'b1;

    // State transition logic
    always @(*) begin
        case (state)
            OFF: if (j) next_state = ON;
                 else next_state = OFF;
            ON: if (k) next_state = OFF;
                else next_state = ON;
            default: next_state = OFF;
        endcase
    end

    // State register
    always @(posedge clk) begin
        if (reset) state <= OFF;
        else state <= next_state;
    end

    // Output logic
    always @(posedge clk) begin
        if (reset) out <= 1'b0;
        else out <= (state == ON);
    end

endmodule
