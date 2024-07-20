module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output reg [1:0] state
);

    // State encoding for a two-bit counter.
    localparam [1:0]
        STRONGLY_NOT_TAKEN = 2'b00,
        WEAKLY_NOT_TAKEN = 2'b01,
        WEAKLY_TAKEN = 2'b10,
        STRONGLY_TAKEN = 2'b11;

    // Asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= WEAKLY_NOT_TAKEN; // Reset state to weakly not-taken
        end else if (train_valid) begin
            if (train_taken) begin
                // Increment the counter, saturating at strongly taken
                if (state < STRONGLY_TAKEN)
                    state <= state + 2'b01;
            end else begin
                // Decrement the counter, saturating at strongly not-taken
                if (state > STRONGLY_NOT_TAKEN)
                    state <= state - 2'b01;
            end
        end
    end

endmodule
