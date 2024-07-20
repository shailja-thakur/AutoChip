module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b01; // Weakly not-taken state
        end
        else if (train_valid) begin
            if (train_taken) begin
                if (state < 2'b11) begin
                    state <= state + 1;
                end
                // If state is already 2'b11, it saturates and remains unchanged
            end
            else begin
                if (state > 2'b00) begin
                    state <= state - 1;
                end
                // If state is already 2'b00, it saturates and remains unchanged
            end
        end
        // If train_valid is 0, state remains unchanged
    end

endmodule
