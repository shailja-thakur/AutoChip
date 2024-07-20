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
                    if (train_taken) begin
                        state <= 2'b01; // Transition to next state
                    end
                    else begin
                        state <= 2'b00; // Remain in current state
                    end
                end
                2'b01: begin
                    if (train_taken) begin
                        state <= 2'b10; // Transition to next state
                    end
                    else begin
                        state <= 2'b00; // Transition to previous state
                    end
                end
                2'b10: begin
                    if (train_taken) begin
                        state <= 2'b11; // Transition to next state
                    end
                    else begin
                        state <= 2'b01; // Transition to previous state
                    end
                end
                2'b11: begin
                    if (train_taken) begin
                        state <= 2'b11; // Remain in current state
                    end
                    else begin
                        state <= 2'b10; // Transition to previous state
                    end
                end
            endcase
        end
    end

endmodule
