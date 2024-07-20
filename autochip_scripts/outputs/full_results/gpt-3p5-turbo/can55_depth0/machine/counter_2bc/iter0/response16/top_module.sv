module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);
reg [1:0] state_reg;
always @(posedge clk or posedge areset) begin
    if (areset)
        state_reg <= 2'b01; // Reset state to 01
    else if (train_valid) begin
        if (train_taken && state_reg < 2'b11) // Transition to next state if train_taken is asserted and current state is less than 11
            state_reg <= state_reg + 1;
        else if (!train_taken && state_reg > 2'b00) // Transition to previous state if train_taken is not asserted and current state is greater than 00
            state_reg <= state_reg - 1;
    end
end
assign state = state_reg;
endmodule
