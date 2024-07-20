module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // Internal register to hold the current state
    logic [1:0] current_state;

    // Assign initial state based on reset signal
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= 2'b01;
        end else begin
            current_state <= current_state;
        end
    end

    // State machine logic
    always_ff @(posedge clk) begin
        if (train_valid) begin
            if (train_taken && (current_state < 2'b11)) begin
                current_state <= current_state + 1'b1;
            end else if (!train_taken && (current_state > 2'b00)) begin
                current_state <= current_state - 1'b1;
            end else begin
                current_state <= current_state; // Keep current state if no transition
            end
        end else begin
            current_state <= current_state; // Keep current state if train_valid is not asserted
        end
    end

    // Assign current state to output
    assign state = current_state;

endmodule
