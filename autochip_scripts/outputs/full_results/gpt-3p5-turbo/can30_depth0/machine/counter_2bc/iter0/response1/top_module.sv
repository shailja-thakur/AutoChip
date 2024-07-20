module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // State register
    logic [1:0] current_state;

    // Next state assignment
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            // Reset to state 1
            current_state <= 2'b01;
        end else if (train_valid) begin
            // Transition to next state if train_taken is asserted
            if (train_taken && current_state < 2'b11) begin
                current_state <= current_state + 1;
            // Transition to previous state if train_taken is de-asserted
            end else if (!train_taken && current_state > 2'b00) begin
                current_state <= current_state - 1;
            end
        end
    end

    // Output assignment
    assign state = current_state;

endmodule
