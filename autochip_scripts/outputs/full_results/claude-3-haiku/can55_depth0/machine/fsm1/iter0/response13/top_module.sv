module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

parameter STATE_A = 1'b0;
parameter STATE_B = 1'b1;

reg state;

always @(posedge clk, posedge areset) begin
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
            default: begin
                state <= STATE_B;
            end
        endcase
    end
end

always @(*) begin
    case (state)
        STATE_A: begin
            out = 1'b0;
        end
        STATE_B: begin
            out = 1'b1;
        end
        default: begin
            out = 1'b0;
        end
    endcase
end

endmodule
