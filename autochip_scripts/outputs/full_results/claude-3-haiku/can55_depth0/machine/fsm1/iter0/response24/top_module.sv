module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

reg state;
localparam STATE_A = 1'b0, STATE_B = 1'b1;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= STATE_B;
    end
    else begin
        case (state)
            STATE_A: begin
                if (in)
                    state <= STATE_A;
                else
                    state <= STATE_B;
            end
            STATE_B: begin
                if (in)
                    state <= STATE_B;
                else
                    state <= STATE_A;
            end
        endcase
    end
end

always @* begin
    if (state == STATE_B)
        out = 1'b1;
    else
        out = 1'b0;
end

endmodule
