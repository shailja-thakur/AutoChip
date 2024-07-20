module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

localparam OFF = 1'b0, ON = 1'b1;
reg state;

always @(posedge clk or posedge areset) begin
    if (areset)
        state <= OFF;
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
            default:
                state <= OFF;
        endcase
    end
end

endmodule
