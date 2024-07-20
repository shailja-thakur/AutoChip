module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

reg state;
parameter STATE_A = 1'b0, STATE_B = 1'b1;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= STATE_B;
    end
    else begin
        case (state)
            STATE_A: begin
                if (in) begin
                    state <= STATE_A;
                end
                else begin
                    state <= STATE_B;
                end
            end
            STATE_B: begin
                if (in) begin
                    state <= STATE_B;
                end
                else begin
                    state <= STATE_A;
                end
            end
        endcase
    end
end

always @(*) begin
    case (state)
        STATE_A: out = 1'b0;
        STATE_B: out = 1'b1;
    endcase
end

endmodule
