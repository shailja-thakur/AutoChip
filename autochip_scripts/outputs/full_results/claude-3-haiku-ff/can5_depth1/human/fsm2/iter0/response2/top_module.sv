module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

    // Define the states
    parameter OFF = 1'b0, ON = 1'b1;
    reg state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            OFF: begin
                if (j == 1'b0) next_state = OFF;
                else if (j == 1'b1) next_state = ON;
            end
            ON: begin
                if (k == 1'b0) next_state = ON;
                else if (k == 1'b1) next_state = OFF;
            end
            default: next_state = OFF;
        endcase
    end

    // State register
    always @(posedge clk, posedge areset) begin
        if (areset) state <= OFF;
        else state <= next_state;
    end

    // Output logic
    always @(*) begin
        case (state)
            OFF: out = 1'b0;
            ON: out = 1'b1;
            default: out = 1'b0;
        endcase
    end

endmodule
