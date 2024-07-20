module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // Internal signal declaration
    logic [1:0] current_state;

    // State machine process
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= 2'b01;  // Reset to state 1
        end else if (train_valid) begin
            case (current_state)
                2'b00: begin
                    if (train_taken) begin
                        current_state <= 2'b01;  // Transition to state 1
                    end else begin
                        current_state <= 2'b00;  // Remain in state 0
                    end
                end
                2'b01: begin
                    if (train_taken) begin
                        current_state <= 2'b10;  // Transition to state 2
                    end else begin
                        current_state <= 2'b00;  // Transition to state 0
                    end
                end
                2'b10: begin
                    if (train_taken) begin
                        current_state <= 2'b11;  // Transition to state 3
                    end else begin
                        current_state <= 2'b01;  // Transition to state 1
                    end
                end
                2'b11: begin
                    if (train_taken) begin
                        current_state <= 2'b11;  // Remain in state 3
                    end else begin
                        current_state <= 2'b10;  // Transition to state 2
                    end
                end
            endcase
        end
    end

    // Assign output
    assign state = current_state;

endmodule
