module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    reg state, next_state;

    // State encoding
    parameter START = 1'b0, INVERT = 1'b1;

    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= START;
        else
            state <= next_state;
    end

    always @(*) begin
        case (state)
            START: begin
                if (x == 1)
                    next_state = INVERT;
                else
                    next_state = START;
            end
            INVERT: begin
                next_state = INVERT;
            end
            default: next_state = START;
        endcase
    end

    always @(posedge clk) begin
        if (areset)
            z <= 1'b0;
        else
            case (state)
                START: z <= x;
                INVERT: z <= ~x;
            endcase
    end

endmodule
