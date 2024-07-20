module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // Define state register
    logic [1:0] state_reg, state_next;
    
    // State assignment to output
    assign state = state_reg;
    
    // Asynchronous reset logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state_reg <= 2'b01; // Reset to state 1
        end else begin
            state_reg <= state_next;
        end
    end
    
    // Next state logic
    always_comb begin
        state_next = state_reg; // Default to staying in the current state
        if (train_valid) begin
            if (train_taken) begin
                if (state_reg < 2'b11) begin
                    state_next = state_reg + 2'b01;
                end
            end else begin
                if (state_reg > 2'b00) begin
                    state_next = state_reg - 2'b01;
                end
            end
        end
    end

endmodule
