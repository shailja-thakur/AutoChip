module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // Internal signal to hold the current counter value
    logic [1:0] counter;
  
    // Sequential logic for updating the counter value
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            counter <= 2'b01; // Reset the counter to weakly not-taken
        end else if (train_valid) begin
            if (train_taken) begin
                if (counter < 2'b11) begin
                    counter <= counter + 1; // Increment the counter (up to a maximum of 3)
                end
            end else begin
                if (counter > 2'b00) begin
                    counter <= counter - 1; // Decrement the counter (down to a minimum of 0)
                end
            end
        end
    end
    
    // Assign the counter value to the output
    assign state = counter;
    
endmodule
