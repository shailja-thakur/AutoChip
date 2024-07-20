module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // Internal signal to hold the counter value
    logic [1:0] counter;

    // Saturating counter logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            counter <= 2'b01; // Resets the counter to weakly not-taken
        else if (train_valid) begin
            if (train_taken && counter < 2'b11) // Increment when train_valid = 1 and train_taken = 1
                counter <= counter + 1;
            else if (!train_taken && counter > 2'b00) // Decrement when train_valid = 1 and train_taken = 0
                counter <= counter - 1;
        end
    end

    // Assign counter value to output
    assign state = counter;

endmodule
