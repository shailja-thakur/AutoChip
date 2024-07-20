module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            state <= 2'b01; // weakly not-taken
        else if (train_valid) begin
            if (train_taken) begin
                if (state < 2'b11) // Maximum value is 3
                    state <= state + 2'b01;
            end else begin
                if (state > 2'b00) // Minimum value is 0
                    state <= state - 2'b01;
            end
        end
    end

endmodule
