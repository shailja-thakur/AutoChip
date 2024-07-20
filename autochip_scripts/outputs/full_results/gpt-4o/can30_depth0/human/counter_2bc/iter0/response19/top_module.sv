module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            state <= 2'b01; // Weakly not-taken
        else if (train_valid) begin
            if (train_taken) begin
                if (state < 2'b11)
                    state <= state + 1;
                else
                    state <= 2'b11; // Saturate at 3
            end else begin
                if (state > 2'b00)
                    state <= state - 1;
                else
                    state <= 2'b00; // Saturate at 0
            end
        end
    end

endmodule
