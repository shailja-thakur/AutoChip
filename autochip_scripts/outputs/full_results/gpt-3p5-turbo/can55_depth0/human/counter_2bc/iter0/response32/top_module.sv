module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);
    // Define internal signal
    logic [1:0] counter;
    
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            counter <= 2'b01; // Reset to weakly not-taken
        else if (train_valid) begin
            if (train_taken)
                counter <= (counter == 2'b11) ? counter : counter + 1; // Increment counter
            else
                counter <= (counter == 2'b00) ? counter : counter - 1; // Decrement counter
        end
    end
    
    assign state = counter; // Assign counter value to output
    
endmodule
