module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);
    
    // Internal signal to hold the counter value
    reg [1:0] counter;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            counter <= 2'b01; // Reset counter to weakly not-taken
        end else begin
            if (train_valid) begin
                if (train_taken && (counter < 2'b11)) begin
                    counter <= counter + 1; // Increment counter if train_taken = 1 and counter is less than 3
                end else if (!train_taken && (counter > 2'b00)) begin
                    counter <= counter - 1; // Decrement counter if train_taken = 0 and counter is greater than 0
                end
            end
        end
    end
    
    // Assign the counter value to the output
    assign state = counter;
    
endmodule
