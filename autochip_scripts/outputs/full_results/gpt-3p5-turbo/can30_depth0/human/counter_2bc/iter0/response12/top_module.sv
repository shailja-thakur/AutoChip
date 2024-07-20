module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // Registers for the counter value
    logic [1:0] counter_reg;
    logic [1:0] counter_next;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            // Reset the counter to weakly not-taken (2'b01)
            counter_reg <= 2'b01;
        end else begin
            // Update the counter value based on train_valid and train_taken signals
            if (train_valid) begin
                if (train_taken) begin
                    // Increment the counter
                    counter_next <= counter_reg + 1;
                end else begin
                    // Decrement the counter
                    counter_next <= counter_reg - 1;
                end
            end else begin
                // Keep the counter unchanged
                counter_next <= counter_reg;
            end
        end
    end

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            // Reset the counter to weakly not-taken (2'b01)
            state <= 2'b01;
        end else begin
            // Update the output state based on the counter value
            if (train_valid) begin
                state <= counter_next;
            end else begin
                // Keep the output state unchanged
                state <= state;
            end
        end
    end

endmodule
