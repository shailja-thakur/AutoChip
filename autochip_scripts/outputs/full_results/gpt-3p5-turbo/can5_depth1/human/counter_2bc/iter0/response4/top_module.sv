module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // Register to hold the current counter value
    reg [1:0] counter;

    // Positive edge triggered asynchronous reset
    always @(posedge clk, posedge areset)
    begin
        if (areset)
            counter <= 2'b01; // Reset to weakly not-taken
        else if (train_valid && train_taken)
            counter <= (counter == 2'b11) ? 2'b11 : counter + 1; // Increment when train_valid = 1 and train_taken = 1
        else if (train_valid && !train_taken)
            counter <= (counter == 2'b00) ? 2'b00 : counter - 1; // Decrement when train_valid = 1 and train_taken = 0
    end

    // Assign counter value to output state
    assign state = counter;

endmodule
