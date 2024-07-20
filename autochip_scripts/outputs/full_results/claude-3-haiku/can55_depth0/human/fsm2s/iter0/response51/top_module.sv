module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

    // Define the states
    parameter OFF = 1'b0;
    parameter ON = 1'b1;

    // Register to hold the current state
    reg state;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Synchronous reset to state OFF
            state <= OFF;
            out <= 1'b0;
        end
        else begin
            case (state)
                OFF: begin
                    if (j) begin
                        // Transition from OFF to ON
                        state <= ON;
                        out <= 1'b1;
                    end
                    else begin
                        // Remain in OFF state
                        state <= OFF;
                        out <= 1'b0;
                    end
                end
                ON: begin
                    if (k) begin
                        // Transition from ON to OFF
                        state <= OFF;
                        out <= 1'b0;
                    end
                    else begin
                        // Remain in ON state
                        state <= ON;
                        out <= 1'b1;
                    end
                end
                default: begin
                    // Shouldn't get here, but just in case
                    state <= OFF;
                    out <= 1'b0;
                end
            endcase
        end
    end

endmodule
