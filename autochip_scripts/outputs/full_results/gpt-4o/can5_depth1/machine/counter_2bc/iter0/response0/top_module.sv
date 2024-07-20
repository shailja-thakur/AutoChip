module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // State register
    logic [1:0] state_reg, state_next;
    
    // State transition logic
    always @(*) begin
        state_next = state_reg;  // Default state no transition
        if (train_valid) begin
            if (train_taken) begin
                if (state_reg < 2'b11) state_next = state_reg + 1;
            end else begin
                if (state_reg > 2'b00) state_next = state_reg - 1;
            end
        end
    end
    
    // State register update logic with asynchronous reset
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            state_reg <= 2'b01;  // Reset to state 1
        else
            state_reg <= state_next;
    end
    
    // Assign output state
    assign state = state_reg;

endmodule
