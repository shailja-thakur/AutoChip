module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // Internal variable to store the current state of the counter
    reg [1:0] counter_state;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            counter_state <= 2'b01; // Reset to weakly not-taken
        end else if (train_valid) begin
            if (train_taken) begin
                if (counter_state == 2'b11) begin
                    counter_state <= 2'b11; // Saturate at maximum value (3)
                end else begin
                    counter_state <= counter_state + 1; // Increment
                end
            end else begin
                if (counter_state == 2'b00) begin
                    counter_state <= 2'b00; // Saturate at minimum value (0)
                end else begin
                    counter_state <= counter_state - 1; // Decrement
                end
            end
        end
    end

    assign state = counter_state; // Output the counter state

endmodule
