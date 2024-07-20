module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);
    logic [1:0] counter;

    // Positive edge triggered asynchronous reset
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            counter <= 2'b01; // Reset counter to weakly not-taken
        else if (train_valid) begin
            // Increment counter when train_valid = 1 and train_taken = 1
            if (train_taken)
                counter <= counter + 1;
            // Decrement counter when train_valid = 1 and train_taken = 0
            else
                counter <= counter - 1;
        end
    end
    
    assign state = counter;
endmodule
