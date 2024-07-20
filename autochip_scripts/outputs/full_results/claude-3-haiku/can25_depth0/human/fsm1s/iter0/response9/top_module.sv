module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // Define the states
    localparam STATE_A = 1'b0;
    localparam STATE_B = 1'b1;

    // Register to hold the current state
    reg state;

    always @(posedge clk) begin
        if (reset) begin
            // Reset the state to B
            state <= STATE_B;
            out <= 1'b1;
        end else begin
            case (state)
                STATE_A: begin
                    // State A
                    out <= 1'b0;
                    if (in) begin
                        // Transition from A to A
                        state <= STATE_A;
                    end else begin
                        // Transition from A to B
                        state <= STATE_B;
                    end
                end
                STATE_B: begin
                    // State B
                    out <= 1'b1;
                    if (in) begin
                        // Transition from B to B
                        state <= STATE_B;
                    end else begin
                        // Transition from B to A
                        state <= STATE_A;
                    end
                end
                default: begin
                    // Unexpected state, reset to B
                    state <= STATE_B;
                    out <= 1'b1;
                end
            endcase
        end
    end

endmodule
