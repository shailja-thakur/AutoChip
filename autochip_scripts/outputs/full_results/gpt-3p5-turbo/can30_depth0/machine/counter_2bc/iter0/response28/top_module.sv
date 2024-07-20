module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

// State register
reg [1:0] current_state;

// Next state logic and state transition
always @(posedge clk or posedge areset) begin
    if (areset) begin
        current_state <= 1; // Reset state
    end else if (train_valid) begin
        if (train_taken && (current_state < 3)) begin
            current_state <= current_state + 1; // Transition to next state
        end else if (!train_taken && (current_state > 0)) begin
            current_state <= current_state - 1; // Transition to previous state
        end
    end
end

// Output assignment
assign state = current_state;

endmodule
