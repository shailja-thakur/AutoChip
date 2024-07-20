module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

// Declare state register
logic [1:0] state_reg;

always_ff @(posedge clk, posedge areset) begin
    if (areset) begin
        state_reg <= 2'b01; // Reset to weakly not-taken
    end
    else begin
        if (train_valid) begin
            if (train_taken) begin
                // Increment up to a maximum of 3
                state_reg <= (state_reg == 2'b11) ? 2'b11 : state_reg + 1'b1;
            end
            else begin
                // Decrement down to a minimum of 0
                state_reg <= (state_reg == 2'b00) ? 2'b00 : state_reg - 1'b1;
            end
        end
        else begin
            // Keep state unchanged when not training
            state_reg <= state_reg;
        end
    end
end

// Assign output
assign state = state_reg;

endmodule
