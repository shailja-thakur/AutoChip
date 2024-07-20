module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    always_ff @(posedge clk, posedge areset) begin
        if (areset) begin
            state <= 2'd1;
        end
        else if (train_valid) begin
            if (train_taken && state < 2'd3) begin
                state <= state + 2'd1;
            end
            else if (!train_taken && state > 2'd0) begin
                state <= state - 2'd1;
            end
            // else state remains unchanged
        end
    end

endmodule
