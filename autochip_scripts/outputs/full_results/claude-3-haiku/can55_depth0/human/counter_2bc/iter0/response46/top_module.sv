module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

always_ff @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= 2'b01; // reset to weakly not-taken
    end
    else begin
        if (train_valid) begin
            if (train_taken) begin
                if (state < 2'b11) begin // check if counter is less than max
                    state <= state + 1'b1; // increment counter
                end
            end
            else begin
                if (state > 2'b00) begin // check if counter is greater than min
                    state <= state - 1'b1; // decrement counter
                end
            end
        end
        else begin
            state <= state; // keep the counter value unchanged
        end
    end
end

endmodule
