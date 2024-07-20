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
    else if (train_valid) begin
        if (train_taken) begin
            if (state < 3'b11) begin // check for max value
                state <= state + 1'b1; // increment counter
            end
            else begin
                state <= 3'b11; // saturate at max value
            end
        end
        else begin
            if (state > 2'b00) begin // check for min value
                state <= state - 1'b1; // decrement counter
            end
            else begin
                state <= 2'b00; // saturate at min value
            end
        end
    end
    // else: state <= state; // keep value unchanged when not training
end

endmodule
