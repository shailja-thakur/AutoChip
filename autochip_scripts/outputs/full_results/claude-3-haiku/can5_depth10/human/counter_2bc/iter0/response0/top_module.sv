module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= 2'b01;
    end
    else if (train_valid) begin
        if (train_taken) begin
            state <= (state == 2'b11) ? state : state + 1; // Increment counter up to 3
        end
        else begin
            state <= (state == 2'b00) ? state : state - 1; // Decrement counter down to 0
        end
    end
    // If train_valid is 0, keep the counter value unchanged
end

endmodule
