module top_module (
    input clk,
    input in,
    input areset,
    output out
);

    parameter STATE_A = 1'b0, STATE_B = 1'b1;
    reg state, next_state;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= STATE_B;
        end else begin
            state <= next_state;
        end
    end

    always @(*) begin
        case (state)
            STATE_A: begin
                if (in) begin
                    next_state = STATE_A;
                end else begin
                    next_state = STATE_B;
                end
            end
            STATE_B: begin
                if (in) begin
                    next_state = STATE_B;
                end else begin
                    next_state = STATE_A;
                end
            end
            default: begin
                next_state = STATE_B;
            end
        endcase
    end

    assign out = (state == STATE_B) ? 1'b1 : 1'b0;

endmodule
