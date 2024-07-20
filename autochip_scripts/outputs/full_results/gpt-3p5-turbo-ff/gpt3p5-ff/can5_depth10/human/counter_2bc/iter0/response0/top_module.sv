module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);
    
    // Internal state variable
    logic [1:0] counter_state;
    
    // Asynchronous reset
    always_ff @(posedge clk or posedge areset)
    begin
        if (areset)
            counter_state <= 2'b01; // Reset to weakly not-taken
        else if (train_valid)
        begin
            if (train_taken)
            begin
                if (counter_state < 2'b11)
                    counter_state <= counter_state + 1; // Increment counter
            end
            else
            begin
                if (counter_state > 2'b00)
                    counter_state <= counter_state - 1; // Decrement counter
            end
        end
    end
    
    // Output assignment
    assign state = counter_state;
    
endmodule
