module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // Define counter and flip-flops
    logic [1:0] counter;
    logic [1:0] next_counter;

    // Process block to update the counter value
    // based on the input values
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            // Reset the counter to weakly not-taken (2'b01)
            counter <= 2'b01;
        end else if (train_valid) begin
            // Increment or decrement the counter based on train_taken
            case (train_taken)
                1'b0: next_counter = (counter == 2'b00) ? 2'b00 : counter - 1;
                1'b1: next_counter = (counter == 2'b11) ? 2'b11 : counter + 1;
                default: next_counter = counter; // Default case keeps the counter unchanged
            endcase
            counter <= next_counter; // Update the counter value
        end
    end

    // Assign the state output
    assign state = counter;

endmodule
