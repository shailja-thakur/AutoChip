module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);
    
    // Registers to hold the current counter value
    logic [1:0] counter_reg;
    
    // Logic for counter incrementing and decrementing
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            counter_reg <= 2'b01;  // Reset counter to weakly not-taken
        end else begin
            if (train_valid) begin
                if (train_taken) begin
                    counter_reg <= counter_reg + 1;  // Increment counter
                end else begin
                    counter_reg <= counter_reg - 1;  // Decrement counter
                end
            end
        end
    end
    
    // Assign the counter value to the output
    assign state = counter_reg;
    
endmodule
