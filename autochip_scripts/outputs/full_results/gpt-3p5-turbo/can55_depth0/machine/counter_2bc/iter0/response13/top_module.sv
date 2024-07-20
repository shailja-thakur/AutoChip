module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // Internal state register
    logic [1:0] current_state;

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            // Reset state to 1
            current_state <= 2'b01;
        end else if (train_valid) begin
            // Transition between states based on train_taken signal
            case (current_state)
                2'b00: begin
                    if (train_taken)
                        current_state <= 2'b01;
                end
                2'b01: begin
                    if (train_taken)
                        current_state <= 2'b10;
                    else
                        current_state <= 2'b00;
                end
                2'b10: begin
                    if (!train_taken)
                        current_state <= 2'b01;
                    else
                        current_state <= 2'b11;
                end
                2'b11: begin
                    if (!train_taken)
                        current_state <= 2'b10;
                end
                default: current_state <= 2'b00;
            endcase
        end
    end

    // Assign current state to output
    assign state = current_state;

endmodule
