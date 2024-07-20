module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // Internal signal to hold the counter value
    logic [1:0] counter_value;

    always @(posedge clk, posedge areset) begin
        if (areset) begin
            // Reset the counter to weakly not-taken (2'b01)
            counter_value <= 2'b01;
        end else begin
            // Increment the counter if train_valid = 1 and train_taken = 1
            // Decrement the counter if train_valid = 1 and train_taken = 0
            // Keep the counter value unchanged if train_valid = 0
            case ({train_valid, train_taken})
                2'b01: counter_value <= counter_value - 1;  // Decrement
                2'b11: counter_value <= counter_value + 1;  // Increment
                default: counter_value <= counter_value;    // Unchanged
            endcase
        end
    end

    // Assign the counter value to the output state
    assign state = counter_value;

endmodule
