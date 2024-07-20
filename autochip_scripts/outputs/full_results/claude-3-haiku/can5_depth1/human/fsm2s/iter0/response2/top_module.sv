module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

// State variables
reg state;
parameter OFF = 1'b0, ON = 1'b1;

always @(posedge clk) begin
    if (reset) begin
        state <= OFF;
        out <= 1'b0;
    end
    else begin
        case (state)
            OFF: begin
                out <= 1'b0;
                if (j)
                    state <= ON;
                else
                    state <= OFF;
            end
            ON: begin
                out <= 1'b1;
                if (k)
                    state <= OFF;
                else
                    state <= ON;
            end
            default:
                state <= OFF;
        endcase
    end
end

endmodule
