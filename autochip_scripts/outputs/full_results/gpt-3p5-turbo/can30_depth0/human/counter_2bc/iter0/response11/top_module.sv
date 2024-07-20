module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);
    
    // Internal counter signal
    logic [1:0] counter;
    
    // Asynchronous reset
    always_ff @(posedge areset)
    begin
        if (areset)
            counter <= 2'b01; // Reset to weakly not-taken
    end
    
    // Counter logic
    always_ff @(posedge clk)
    begin
        if (train_valid)
        begin
            if (train_taken)
            begin
                if (counter < 2)
                    counter <= counter + 1; // Increment counter
            end
            else
            begin
                if (counter > 0)
                    counter <= counter - 1; // Decrement counter
            end
        end
    end
    
    // Assign counter value to output
    assign state = counter;
    
endmodule
