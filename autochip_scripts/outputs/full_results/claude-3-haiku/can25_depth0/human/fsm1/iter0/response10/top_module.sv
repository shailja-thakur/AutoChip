module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    // Define the states
    parameter STATE_A = 1'b0;
    parameter STATE_B = 1'b1;

    // Register to hold the current state
    reg current_state, next_state;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= STATE_B;
        end
        else begin
            current_state <= next_state;
        end
    end

    always @(*) begin
        // Next state logic
        case (current_state)
            STATE_A: begin
                if (in)
                    next_state = STATE_A;
                else
                    next_state = STATE_B;
            end
            STATE_B: begin
                if (in)
                    next_state = STATE_B;
                else
                    next_state = STATE_A;
            end
            default: begin
                next_state = STATE_B;
            end
        endcase

        // Output logic
        case (current_state)
            STATE_A: out = 1'b0;
            STATE_B: out = 1'b1;
            default: out = 1'b0;
        endcase
    end

endmodule
