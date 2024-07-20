module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    always_ff @(posedge clk, posedge areset) begin
        if (areset) begin
            state <= 2'b01; // Reset to state 1
        end
        else if (train_valid) begin
            case (state)
                2'b00: // State 0
                    if (train_taken) begin
                        state <= 2'b01; // Transition to state 1
                    end
                2'b01: // State 1
                    if (train_taken) begin
                        state <= 2'b10; // Transition to state 2
                    end
                    else begin
                        state <= 2'b00; // Transition to state 0
                    end
                2'b10: // State 2
                    if (train_taken) begin
                        state <= 2'b11; // Transition to state 3
                    end
                    else begin
                        state <= 2'b01; // Transition to state 1
                    end
                2'b11: // State 3
                    if (!train_taken) begin
                        state <= 2'b10; // Transition to state 2
                    end
            endcase
        end
    end

endmodule
