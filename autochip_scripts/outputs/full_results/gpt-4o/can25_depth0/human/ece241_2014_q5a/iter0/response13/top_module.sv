module top_module (
    input clk,
    input areset,
    input x,
    output z
);

    reg state, next_state;
    reg z_reg;

    // State encoding
    localparam IDLE = 1'b0, INVERT = 1'b1;

    // State transition logic
    always @(*) begin
        case (state)
            IDLE: begin
                if (!areset)
                    next_state = INVERT;
                else
                    next_state = IDLE;
            end
            INVERT: begin
                if (areset)
                    next_state = IDLE;
                else
                    next_state = INVERT;
            end
            default: next_state = IDLE;
        endcase
    end

    // State flip-flops with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Output logic
    always @(posedge clk) begin
        if (state == IDLE)
            z_reg <= 1'b0;
        else
            z_reg <= ~x;
    end

    assign z = z_reg;

endmodule
