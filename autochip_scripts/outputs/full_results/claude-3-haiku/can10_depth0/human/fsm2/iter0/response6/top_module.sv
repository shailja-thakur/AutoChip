module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

    // Define the states
    parameter OFF = 1'b0;
    parameter ON = 1'b1;

    // Define the current state register
    reg state;

    always @(posedge clk, posedge areset) begin
        if (areset) begin
            state <= OFF;
            out <= 1'b0;
        end
        else begin
            case (state)
                OFF: begin
                    out <= 1'b0;
                    if (j) begin
                        state <= ON;
                    end
                    else begin
                        state <= OFF;
                    end
                end
                ON: begin
                    out <= 1'b1;
                    if (k) begin
                        state <= OFF;
                    end
                    else begin
                        state <= ON;
                    end
                end
                default: begin
                    state <= OFF;
                    out <= 1'b0;
                end
            endcase
        end
    end

endmodule
