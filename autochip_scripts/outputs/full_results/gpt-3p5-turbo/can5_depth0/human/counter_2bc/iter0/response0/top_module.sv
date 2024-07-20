module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            state <= 2'b01; // Reset the counter to weakly not-taken
        else if (train_valid) begin
            if (train_taken)
                state <= (state == 2'b11) ? 2'b11 : state + 2'b01; // Increment the counter (up to a maximum of 3)
            else
                state <= (state == 2'b00) ? 2'b00 : state - 2'b01; // Decrement the counter (down to a minimum of 0)
        end
    end
endmodule
