module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

    // States
    parameter OFF = 1'b0;
    parameter ON = 1'b1;

    // State register
    reg state;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= OFF;
            out <= 0;
        end
        else begin
            case (state)
                OFF: begin
                    if (j) begin
                        state <= ON;
                        out <= 1;
                    end
                    else begin
                        state <= OFF;
                        out <= 0;
                    end
                end
                ON: begin
                    if (k) begin
                        state <= OFF;
                        out <= 0;
                    end
                    else begin
                        state <= ON;
                        out <= 1;
                    end
                end
                default: begin
                    state <= OFF;
                    out <= 0;
                end
            endcase
        end
    end

endmodule
