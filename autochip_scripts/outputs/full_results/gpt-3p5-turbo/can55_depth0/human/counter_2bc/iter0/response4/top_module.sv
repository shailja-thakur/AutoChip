module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);
// Declare a temporary variable to store the updated counter value
logic [1:0] temp_state;

always_ff @(posedge clk or posedge areset) begin
    if (areset) begin
        // Reset the counter to 2'b01
        temp_state <= 2'b01;
    end else if (train_valid) begin
        // Increment the counter when train_valid = 1 and train_taken = 1
        if (train_taken) begin
            if (temp_state == 2'b11) begin
                // Saturate the counter at 2'b11
                temp_state <= 2'b11;
            end else begin
                temp_state <= temp_state + 1;
            end
        // Decrement the counter when train_valid = 1 and train_taken = 0
        end else begin
            if (temp_state == 2'b00) begin
                // Saturate the counter at 2'b00
                temp_state <= 2'b00;
            end else begin
                temp_state <= temp_state - 1;
            end
        end
    end
end

// Assign the value of the temporary variable to the output
assign state = temp_state;

endmodule
