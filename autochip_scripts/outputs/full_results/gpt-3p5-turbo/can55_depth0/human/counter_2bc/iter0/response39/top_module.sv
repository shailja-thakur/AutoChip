module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b01; // Reset the counter to weakly not-taken
        end else if (train_valid) begin
            if (train_taken && (state < 2)) begin
                // Increment the counter when train_valid = 1 and train_taken = 1
                state <= state + 1;
            end else if (!train_taken && (state > 0)) begin
                // Decrement the counter when train_valid = 1 and train_taken = 0
                state <= state - 1;
            end
        end
    end
endmodule
