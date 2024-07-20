module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);
    
    // Internal signals
    logic [1:0] counter;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            // Reset the counter to weakly not-taken
            counter <= 2'b01;
        end else begin
            if (train_valid) begin
                if (train_taken) begin
                    // Increment the counter (up to a maximum of 3)
                    counter <= (counter == 2'b11) ? counter : counter + 1;
                end else begin
                    // Decrement the counter (down to a minimum of 0)
                    counter <= (counter == 2'b00) ? counter : counter - 1;
                end
            end
        end
    end

    // Assign the counter value to the output
    assign state = counter;

endmodule
