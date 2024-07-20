module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // Internal signal declaration for synchronizing train_valid signal
    reg train_valid_sync;

    always @(posedge clk or posedge areset) begin
        if (areset)
            train_valid_sync <= 0;  // Reset train_valid_sync signal to 0
        else
            train_valid_sync <= train_valid;  // Synchronize train_valid signal with clock
    end

    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= 2'b01; // Reset counter value to weakly not-taken
        else begin
            if (train_valid_sync) begin
                if (train_taken && (state < 2'b11))
                    state <= state + 2'b01;  // Increment counter if train_taken is 1 and state is less than 3
                else if (!train_taken && (state > 2'b00))
                    state <= state - 2'b01;  // Decrement counter if train_taken is 0 and state is greater than 0
            end
        end
    end

endmodule
