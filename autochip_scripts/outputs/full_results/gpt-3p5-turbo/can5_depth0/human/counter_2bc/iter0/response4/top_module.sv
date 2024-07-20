module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);
    // Internal signal to store the current counter value
    logic [1:0] counter_value;

    always@(posedge clk or posedge areset) begin
        if (areset) begin
            // Reset the counter to weakly not-taken (2'b01)
            counter_value <= 2'b01;
        end else if (train_valid) begin
            // Increment the counter if train_valid = 1 and train_taken = 1
            if (train_taken)
                counter_value <= (counter_value == 2'b11) ? counter_value : counter_value + 1;
            // Decrement the counter if train_valid = 1 and train_taken = 0
            else
                counter_value <= (counter_value == 2'b00) ? counter_value : counter_value - 1;
        end
    end

    // Assign the counter value to the output state
    always @(counter_value)
        state <= counter_value;

endmodule
