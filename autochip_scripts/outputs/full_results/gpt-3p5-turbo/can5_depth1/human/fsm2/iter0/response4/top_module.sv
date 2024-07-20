module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);
    // Define the states
    parameter OFF = 0;
    parameter ON = 1;

    reg [1:0] state, next_state;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            // Reset to OFF state
            state <= OFF;
        end else begin
            // Transition to next state based on inputs and current state
            case(state)
                OFF: begin
                    if (j) begin
                        next_state <= ON;
                    end else begin
                        next_state <= OFF;
                    end
                end
                ON: begin
                    if (k) begin
                        next_state <= OFF;
                    end else begin
                        next_state <= ON;
                    end
                end
            endcase
        end
    end

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            // Reset output to 0
            out <= 0;
        end else begin
            // Update output based on current state
            case(state)
                OFF: begin
                    out <= 0;
                end
                ON: begin
                    out <= 1;
                end
            endcase
        end
    end
endmodule
