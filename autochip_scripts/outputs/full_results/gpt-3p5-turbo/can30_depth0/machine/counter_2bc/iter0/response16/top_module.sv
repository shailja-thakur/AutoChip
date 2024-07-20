module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // State register
    reg [1:0] state_reg;
    
    always @(posedge clk) begin
        if (areset) begin
            state_reg <= 2'b01; // Reset state to 01
        end else if (train_valid) begin
            if (train_taken && (state_reg < 2'b11)) begin
                state_reg <= state_reg + 1; // Transition to next state
            end else if (!train_taken && (state_reg > 2'b00)) begin
                state_reg <= state_reg - 1; // Transition to previous state
            end
        end
    end
    
    // Assign value of state register to output
    assign state = state_reg;
    
endmodule
