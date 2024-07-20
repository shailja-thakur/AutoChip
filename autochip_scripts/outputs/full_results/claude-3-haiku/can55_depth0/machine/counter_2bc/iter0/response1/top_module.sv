module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b01; // Reset to state 1
        end
        else if (train_valid) begin
            case (state)
                2'b00: begin
                    if (train_taken)
                        state <= 2'b01; // Transition to state 1
                    else
                        state <= 2'b00; // Remain in state 0
                end
                2'b01: begin
                    if (train_taken)
                        state <= 2'b10; // Transition to state 2
                    else
                        state <= 2'b00; // Transition to state 0
                end
                2'b10: begin
                    if (train_taken)
                        state <= 2'b11; // Transition to state 3
                    else
                        state <= 2'b01; // Transition to state 1
                end
                2'b11: begin
                    if (train_taken)
                        state <= 2'b11; // Remain in state 3
                    else
                        state <= 2'b10; // Transition to state 2
                end
                default:
                    state <= 2'b01; // Reset to state 1
            endcase
        end
        else begin
            state <= state; // Remain in the current state
        end
    end

endmodule
