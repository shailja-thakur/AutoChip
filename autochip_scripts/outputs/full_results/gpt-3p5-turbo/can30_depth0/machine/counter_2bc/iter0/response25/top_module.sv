module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // Registers to hold the current state and next state
    logic [1:0] curr_state;
    logic [1:0] next_state;

    // Asynchronous reset
    always_ff @(posedge clk or negedge areset) begin
        if (areset == 0) begin
            curr_state <= 1;
        end else begin
            curr_state <= next_state;
        end
    end

    // State transition logic
    always_ff @(posedge clk) begin
        next_state = curr_state;
        if (train_valid) begin
            if (train_taken && curr_state < 3) begin
                next_state = curr_state + 1;
            end else if (!train_taken && curr_state > 0) begin
                next_state = curr_state - 1;
            end
        end
    end

    // Output assignment
    assign state = curr_state;

endmodule
