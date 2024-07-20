module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // Declare internal state variable
    logic [1:0] current_state;

    // On asynchronous reset, set state to 1
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            current_state <= 2'b01;
    end

    // State machine logic
    always_ff @(posedge clk) begin
        if (train_valid) begin
            if (train_taken && current_state < 2'b11) // Transition to next state
                current_state <= current_state + 1;
            else if (!train_taken && current_state > 2'b00) // Transition to previous state
                current_state <= current_state - 1;
        end
    end

    // Assign state output
    assign state = current_state;

endmodule
