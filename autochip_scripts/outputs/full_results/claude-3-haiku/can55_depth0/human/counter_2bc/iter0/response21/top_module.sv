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
    else begin
        if (train_valid) begin
            if (train_taken) begin
                state <= (state == 2'b11) ? 2'b11 : state + 1'b1; // increment up to 3
            end
            else begin
                state <= (state == 2'b00) ? 2'b00 : state - 1'b1; // decrement down to 0
            end
        end
        // else keep state unchanged
    end
end

endmodule
