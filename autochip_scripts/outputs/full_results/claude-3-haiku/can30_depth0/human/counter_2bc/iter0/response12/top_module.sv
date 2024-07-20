module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= 2'b01; // reset to weakly not-taken
    end
    else begin
        if (train_valid) begin
            if (train_taken) begin
                if (state != 2'b11) // check for maximum of 3
                    state <= state + 1;
            end
            else begin
                if (state != 2'b00) // check for minimum of 0
                    state <= state - 1;
            end
        end
        // else, keep the state unchanged
    end
end

endmodule
