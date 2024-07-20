module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

reg state;
parameter STATE_A = 1'b0, STATE_B = 1'b1;

always @(*) begin
    case (state)
        STATE_A: begin
            if (j) begin
                state = STATE_B;
            end else begin
                state = STATE_A;
            end
        end
        STATE_B: begin
            if (k) begin
                state = STATE_A;
            end else begin
                state = STATE_B;
            end
        end
        default: begin
            state = STATE_A;
        end
    endcase
end

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= STATE_A;
    end else begin
        state <= state;
    end
end

always @(*) begin
    if (state == STATE_B) begin
        out = 1'b1;
    end else begin
        out = 1'b0;
    end
end

endmodule
