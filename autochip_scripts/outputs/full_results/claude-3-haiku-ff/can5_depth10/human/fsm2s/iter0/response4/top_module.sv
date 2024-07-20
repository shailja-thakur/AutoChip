module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

reg state;
parameter OFF = 1'b0, ON = 1'b1;

always @(posedge clk, posedge reset) begin
    if (reset)
        state <= OFF;
    else begin
        case (state)
            OFF:
                if (j)
                    state <= ON;
                else
                    state <= OFF;
            ON:
                if (k)
                    state <= OFF;
                else
                    state <= ON;
            default:
                state <= OFF;
        endcase
    end
end

always @(state) begin
    case (state)
        OFF: out <= 1'b0;
        ON: out <= 1'b1;
        default: out <= 1'b0;
    endcase
end

endmodule
