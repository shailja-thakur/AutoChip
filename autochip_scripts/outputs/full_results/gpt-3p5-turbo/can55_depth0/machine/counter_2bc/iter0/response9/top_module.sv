module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // Internal state signal
    reg [1:0] current_state;

    always @(posedge clk or posedge areset) begin
        if (areset)
            current_state <= 1; // Reset to state 1
        else if (train_valid) begin
            if (train_taken && (current_state < 3))
                current_state <= current_state + 1; // Next state
            else if (!train_taken && (current_state > 0))
                current_state <= current_state - 1; // Previous state
        end
    end

    assign state = current_state;

endmodule
