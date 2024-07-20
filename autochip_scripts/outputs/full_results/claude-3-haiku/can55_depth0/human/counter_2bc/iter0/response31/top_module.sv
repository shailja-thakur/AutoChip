module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

always_ff @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= 2'b01; // reset to weakly not-taken
    end
    else if (train_valid) begin
        if (train_taken) begin
            if (state < 3) begin
                state <= state + 1; // increment counter
            end
            else begin
                state <= 3; // saturate at maximum
            end
        end
        else begin
            if (state > 0) begin
                state <= state - 1; // decrement counter
            end
            else begin
                state <= 0; // saturate at minimum
            end
        end
    end
    // else, keep state unchanged when train_valid is 0
end

endmodule
