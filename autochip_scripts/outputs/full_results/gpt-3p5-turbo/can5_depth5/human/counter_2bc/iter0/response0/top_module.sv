module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // Internal signal to hold the current counter value
    logic [1:0] counter;

    // Asynchronous reset
    always_ff @(posedge areset)
    begin
        counter <= 2'b01; // Reset to weakly not-taken
    end

    // Synchronous counter logic
    always_ff @(posedge clk)
    begin
        if (train_valid)
        begin
            if (train_taken) // Increment the counter
            begin
                if (counter == 2'b11)
                    counter <= 2'b11; // Saturate at maximum value of 3
                else
                    counter <= counter + 1;
            end
            else // Decrement the counter
            begin
                if (counter == 2'b00)
                    counter <= 2'b00; // Saturate at minimum value of 0
                else
                    counter <= counter - 1;
            end
        end
    end

    // Assign the counter value to the output
    assign state = counter;

endmodule
