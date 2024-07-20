module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // Internal signal to hold the current state of the counter
    logic [1:0] counter_state;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            // Reset the counter to weakly not-taken (2'b01)
            counter_state <= 2'b01;
        end
        else if (train_valid) begin
            if (train_taken && (counter_state != 2'b11)) begin
                // Increment the counter when train_valid = 1 and train_taken = 1
                counter_state <= counter_state + 1;
            end
            else if (!train_taken && (counter_state != 2'b00)) begin
                // Decrement the counter when train_valid = 1 and train_taken = 0
                counter_state <= counter_state - 1;
            end
        end
    end
    
    // Output the current state of the counter
    assign state = counter_state;
    
endmodule
