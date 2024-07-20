module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // Internal signal to hold the current state of the counter
    logic [1:0] counter_state;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            counter_state <= 2'b01; // Reset counter to weakly not-taken
        end else begin
            if (train_valid) begin
                if (train_taken) begin
                    if (counter_state < 2'b11) begin // Increment counter
                        counter_state <= counter_state + 1;
                    end
                end else begin
                    if (counter_state > 2'b00) begin // Decrement counter
                        counter_state <= counter_state - 1;
                    end
                end
            end
        end
    end

    // Assign the counter state to the output
    assign state = counter_state;

endmodule
