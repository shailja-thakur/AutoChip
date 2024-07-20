module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

parameter STATE_A = 1'b0;
parameter STATE_B = 1'b1;

reg state;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= STATE_B;
        out <= 1'b1;
    end
    else begin
        case (state)
            STATE_A: begin
                out <= 1'b0;
                if (in) begin
                    state <= STATE_A;
                end
                else begin
                    state <= STATE_B;
                end
            end
            STATE_B: begin
                out <= 1'b1;
                if (in) begin
                    state <= STATE_B;
                end
                else begin
                    state <= STATE_A;
                end
            end
            default: begin
                state <= STATE_B;
                out <= 1'b1;
            end
        endcase
    end
end

endmodule
