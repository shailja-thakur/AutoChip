module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // Define the two states
    localparam STATE_A = 1'b0;
    localparam STATE_B = 1'b1;

    // Register to store the current state
    reg state;

    always @(posedge clk) begin
        if (reset) begin
            // Reset the state to STATE_B
            state <= STATE_B;
            out <= 1'b1;
        end
        else begin
            case (state)
                STATE_B: begin
                    // State B
                    out <= 1'b1;
                    if (in) begin
                        // Transition from B to B
                        state <= STATE_B;
                    end
                    else begin
                        // Transition from B to A
                        state <= STATE_A;
                    end
                end
                STATE_A: begin
                    // State A
                    out <= 1'b0;
                    if (in) begin
                        // Transition from A to A
                        state <= STATE_A;
                    end
                    else begin
                        // Transition from A to B
                        state <= STATE_B;
                    end
                end
                default: begin
                    // Handle any unexpected state
                    state <= STATE_B;
                    out <= 1'b1;
                end
            endcase
        end
    end

endmodule
