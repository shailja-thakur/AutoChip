module top_module(
    input logic clk,
    input logic areset,
    input logic train_valid,
    input logic train_taken,
    output logic [1:0] state
);

    // Declare internal variable for state tracking
    logic [1:0] current_state;

    always_ff @(posedge clk, negedge areset) begin
        if (!areset) begin
            current_state <= 2'b01; // Reset to state 1
        end else begin
            case (current_state)
                2'b00: begin  // State 0
                    if (train_valid && train_taken) begin
                        current_state <= 2'b01; // Transition to state 1
                    end
                end
                2'b01: begin  // State 1
                    if (train_valid && train_taken) begin
                        current_state <= 2'b10; // Transition to state 2
                    end
                    else if (train_valid && !train_taken) begin
                        current_state <= 2'b00; // Transition to state 0
                    end
                end
                2'b10: begin  // State 2
                    if (train_valid && train_taken) begin
                        current_state <= 2'b11; // Transition to state 3
                    end
                    else if (train_valid && !train_taken) begin
                        current_state <= 2'b01; // Transition to state 1
                    end
                end
                2'b11: begin  // State 3
                    if (train_valid && !train_taken) begin
                        current_state <= 2'b10; // Transition to state 2
                    end
                end
                default: current_state <= 2'b01; // Default case, reset to state 1
            endcase
        end
    end

    assign state = current_state;

endmodule
