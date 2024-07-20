module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

// Declare internal state variable
logic [1:0] counter;

always_ff @(posedge clk, posedge areset) begin
    if (areset) begin
        // Reset counter to weakly not-taken (2'b01)
        counter <= 2'b01;
    end
    else begin
        if (train_valid) begin
            // Increment counter when train_valid = 1 and train_taken = 1
            if (train_taken) begin
                if (counter != 3'b11)
                    counter <= counter + 1;
            end
            // Decrement counter when train_valid = 1 and train_taken = 0
            else begin
                if (counter != 3'b00)
                    counter <= counter - 1;
            end
        end
        // Keep counter value unchanged when not training (train_valid = 0)
        else begin
            counter <= counter;
        end
    end
end

// Assign counter value to output state
assign state = counter;

endmodule
