module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // Internal signal to store the counter value
    logic [1:0] counter;

    always@(posedge clk or posedge areset) begin
        if(areset)
            counter <= 2'b01; // Reset the counter to weakly not-taken
        else if(train_valid) begin
            if(train_taken) begin
                // Increment the counter when train_valid = 1 and train_taken = 1
                if(counter == 2'b11)
                    counter <= 2'b11; // Saturate at maximum value of 3
                else
                    counter <= counter + 1;
            end else begin
                // Decrement the counter when train_valid = 1 and train_taken = 0
                if(counter == 2'b00)
                    counter <= 2'b00; // Saturate at minimum value of 0
                else
                    counter <= counter - 1;
            end
        end
    end
    
    assign state = counter;

endmodule
