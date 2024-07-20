module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

    // State declaration
    enum {OFF, ON} state;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= OFF;
            out <= 0;
        end else begin
            case(state)
                OFF: begin
                    if (j)
                        state <= ON;
                    else
                        state <= OFF;
                end
                ON: begin
                    if (k)
                        state <= OFF;
                    else
                        state <= ON;
                end
                default: state <= OFF;
            endcase

            case(state)
                OFF: out <= 0;
                ON: out <= 1;
                default: out <= 0;
            endcase
        end
    end

endmodule
