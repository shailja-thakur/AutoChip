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
                if (state != 2'b11) // check for max counter value
                    state <= state + 1;
            end
            else begin
                if (state != 2'b00) // check for min counter value 
                    state <= state - 1;
            end
        end
        // else keep the counter value unchanged
    end
end

endmodule
