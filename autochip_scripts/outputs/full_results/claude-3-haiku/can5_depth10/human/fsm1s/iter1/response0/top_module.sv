module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // Define the two states
    localparam STATE_A = 1'b0;
    localparam STATE_B = 1'b1;

    // Register to hold the current state
    reg state_reg;

    always @(posedge clk) begin
        if (reset) begin
            state_reg <= STATE_B;
            out <= 1'b1;
        end
        else begin
            case (state_reg)
                STATE_A: begin
                    if (in) begin
                        state_reg <= STATE_A;
                        out <= 1'b0;
                    end
                    else begin
                        state_reg <= STATE_B;
                        out <= 1'b1;
                    end
                end
                STATE_B: begin
                    if (in) begin
                        state_reg <= STATE_B;
                        out <= 1'b1;
                    end
                    else begin
                        state_reg <= STATE_A;
                        out <= 1'b0;
                    end
                end
                default: begin
                    state_reg <= STATE_B;
                    out <= 1'b1;
                end
            endcase
        end
    end

endmodule
