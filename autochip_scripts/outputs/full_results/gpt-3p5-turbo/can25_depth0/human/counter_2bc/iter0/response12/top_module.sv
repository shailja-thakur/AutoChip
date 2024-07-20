module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // Register to hold counter value
    logic [1:0] counter_reg;

    // Next state logic
    always_ff @(posedge clk, posedge areset) begin
        if (areset) begin
            counter_reg <= 2'b01; // Reset to weakly not-taken
        end else if (train_valid) begin
            if (train_taken) begin
                // Increment counter (up to a maximum of 3)
                counter_reg <= counter_reg + 1'b1;
            end else begin
                // Decrement counter (down to a minimum of 0)
                counter_reg <= counter_reg - 1'b1;
            end
        end
    end

    // Assign current counter value to output
    assign state = counter_reg;

endmodule
