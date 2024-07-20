module top_module(
    input logic clk,
    input logic areset,
    input logic train_valid,
    input logic train_taken,
    output logic [1:0] state
);

// Internal signal to hold the current value of the counter
logic [1:0] counter_value;

always_ff @(posedge clk or posedge areset) begin
    if (areset) begin
        // Reset the counter to 2'b01
        counter_value <= 2'b01;
    end else if (train_valid) begin
        if (train_taken) begin
            // Increment the counter when train_valid and train_taken are both 1
            if (counter_value < 2'b11) begin
                counter_value <= counter_value + 1;
            end
        end else begin
            // Decrement the counter when train_valid is 1 and train_taken is 0
            if (counter_value > 2'b00) begin
                counter_value <= counter_value - 1;
            end
        end
    end
end

// Assign the counter value to the output state
assign state = counter_value;

endmodule
