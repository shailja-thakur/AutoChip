module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

localparam  OFF = 1'b0,
            ON = 1'b1;

reg state;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= OFF;
        out <= 1'b0;
    end
    else begin
        case (state)
            OFF: begin
                if (j)
                    state <= ON;
                else
                    state <= OFF;
                out <= 1'b0;
            end
            ON: begin
                if (k)
                    state <= OFF;
                else
                    state <= ON;
                out <= 1'b1;
            end
            default: begin
                state <= OFF;
                out <= 1'b0;
            end
        endcase
    end
end

endmodule
