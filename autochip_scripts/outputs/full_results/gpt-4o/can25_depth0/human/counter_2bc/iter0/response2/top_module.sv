module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output reg [1:0] state
);

    // Define the initial state of the counter
    initial begin
        state = 2'b01; // weakly not-taken
    end

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b01; // Reset the counter to weakly not-taken state
        end
        else if (train_valid) begin
            if (train_taken) begin
                if (state < 2'b11) begin
                    state <= state + 2'b01; // Increment the counter
                end
            end
            else begin
                if (state > 2'b00) begin
                    state <= state - 2'b01; // Decrement the counter
                end
            end
        end
    end
endmodule
