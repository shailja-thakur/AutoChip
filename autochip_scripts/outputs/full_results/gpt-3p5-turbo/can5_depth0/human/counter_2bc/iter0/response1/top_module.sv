module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);
	
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b01; // Initialize counter value to weakly not-taken
        end
        else if (train_valid) begin
            if (train_taken && state < 2'b11) begin
                state <= state + 1; // Increment counter if train_valid and train_taken are both 1 and counter is less than 3
            end
            else if (!train_taken && state > 2'b00) begin
                state <= state - 1; // Decrement counter if train_valid is 1, train_taken is 0, and counter is greater than 0
            end
        end
    end
	
endmodule
