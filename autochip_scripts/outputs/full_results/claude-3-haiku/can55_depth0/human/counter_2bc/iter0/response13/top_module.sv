module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

// Declare a 2-bit register to hold the counter value
logic [1:0] counter;

always_ff @(posedge clk, posedge areset) begin
    if (areset) begin
        counter <= 2'b01; // Reset the counter to weakly not-taken state
    end
    else begin
        if (train_valid) begin
            if (train_taken) begin
                // Increment the counter, clamping to the maximum value of 3
                counter <= (counter == 2'b11) ? 2'b11 : counter + 1'b1;
            end
            else begin
                // Decrement the counter, clamping to the minimum value of 0
                counter <= (counter == 2'b00) ? 2'b00 : counter - 1'b1;
            end
        end
        else begin
            // Keep the counter value unchanged when not training
            counter <= counter;
        end
    end
end

// Assign the counter value to the output state
assign state = counter;

endmodule
