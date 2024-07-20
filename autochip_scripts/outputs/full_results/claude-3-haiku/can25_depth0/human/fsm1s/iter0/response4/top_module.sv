module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // State definitions
    localparam STATE_A = 1'b0;
    localparam STATE_B = 1'b1;

    // State register
    reg state;

    always @(posedge clk) begin
        if (reset) begin
            // Reset state to B
            state <= STATE_B;
        end
        else begin
            case (state)
                STATE_B: begin
                    // State B
                    out <= 1'b1;
                    if (in) begin
                        // B --in=1--> B
                        state <= STATE_B;
                    end
                    else begin
                        // B --in=0--> A
                        state <= STATE_A;
                    end
                end
                STATE_A: begin
                    // State A
                    out <= 1'b0;
                    if (in) begin
                        // A --in=1--> A
                        state <= STATE_A;
                    end
                    else begin
                        // A --in=0--> B
                        state <= STATE_B;
                    end
                end
                default: begin
                    // Should never reach here
                    state <= STATE_B;
                    out <= 1'b0;
                end
            endcase
        end
    end

endmodule
