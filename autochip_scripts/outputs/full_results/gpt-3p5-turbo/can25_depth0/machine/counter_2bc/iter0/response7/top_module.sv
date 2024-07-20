module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // State Definitions
    localparam [1:0] STATE_0 = 2'b00;
    localparam [1:0] STATE_1 = 2'b01;
    localparam [1:0] STATE_2 = 2'b10;
    localparam [1:0] STATE_3 = 2'b11;

    // Registers
    logic [1:0] current_state;

    // State Machine Logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= STATE_1; // Reset state to STATE_1
        end else begin
            case (current_state)
                STATE_0: begin
                    if (train_taken && (current_state < STATE_3))
                        current_state <= current_state + 1; // Transition to next state if taken and not at maximum state
                    end
                end
                STATE_1: begin
                    if (train_valid && train_taken)
                        current_state <= STATE_2; // Transition to STATE_2 if valid and taken
                    else if (!train_taken)
                        current_state <= STATE_0; // Stay in STATE_0 if not taken
                end
                STATE_2: begin
                    if (!train_valid || !train_taken)
                        current_state <= STATE_1; // Transition to STATE_1 if not valid or not taken
                    else if (train_taken && (current_state < STATE_3))
                        current_state <= current_state + 1; // Transition to next state if taken and not at maximum state
                end
                STATE_3: begin
                    if (!train_taken && (current_state > STATE_0))
                        current_state <= current_state - 1; // Transition to previous state if not taken and not at minimum state
                end
            endcase
        end
    end

    // Outputs
    assign state = current_state;

endmodule
