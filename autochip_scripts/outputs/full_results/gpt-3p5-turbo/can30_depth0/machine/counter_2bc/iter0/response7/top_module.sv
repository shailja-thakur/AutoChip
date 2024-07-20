module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // Define the states
    parameter S0 = 0;
    parameter S1 = 1;
    parameter S2 = 2;
    parameter S3 = 3;

    // Declare internal signals
    reg [1:0] current_state;
    reg [1:0] next_state;

    // Reset state machine to state S1 on asynchronous reset signal
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= S1;
        end else begin
            current_state <= next_state;
        end
    end

    // Determine next state based on current state and inputs
    always @(posedge clk) begin
        if (train_valid) begin
            if (train_taken && current_state < S3) begin
                next_state <= current_state + 1;
            end else if (!train_taken && current_state > S0) begin
                next_state <= current_state - 1;
            end
        else begin
                next_state <= current_state;
        end
    end

    // Assign the current state to the output
    always @(posedge clk) begin
        state <= current_state;
    end
endmodule
