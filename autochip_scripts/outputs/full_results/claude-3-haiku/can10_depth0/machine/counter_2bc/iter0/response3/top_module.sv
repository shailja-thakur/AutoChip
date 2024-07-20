module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b01; // Reset state to 1
        end
        else if (train_valid) begin
            case (state)
                2'b00: begin
                    if (train_taken) begin
                        state <= 2'b01; // Transition from 0 to 1
                    end
                    else begin
                        state <= 2'b00; // Remain in state 0
                    end
                end
                2'b01: begin
                    if (train_taken) begin
                        state <= 2'b10; // Transition from 1 to 2
                    end
                    else begin
                        state <= 2'b00; // Transition from 1 to 0
                    end
                end
                2'b10: begin
                    if (train_taken) begin
                        state <= 2'b11; // Transition from 2 to 3
                    end
                    else begin
                        state <= 2'b01; // Transition from 2 to 1
                    end
                end
                2'b11: begin
                    if (train_taken) begin
                        state <= 2'b11; // Remain in state 3
                    end
                    else begin
                        state <= 2'b10; // Transition from 3 to 2
                    end
                end
                default: state <= 2'b01; // Reset to state 1 if invalid state
            endcase
        end
        else begin
            state <= state; // Remain in current state if train_valid is not asserted
        end
    end

endmodule
