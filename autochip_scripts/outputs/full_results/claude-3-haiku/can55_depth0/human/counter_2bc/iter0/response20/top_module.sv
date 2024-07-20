module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

logic [1:0] next_state;

always_comb begin
    next_state = state;
    
    if (train_valid) begin
        if (train_taken)
            next_state = (state == 2'b11) ? 2'b11 : state + 1;
        else
            next_state = (state == 2'b00) ? 2'b00 : state - 1;
    end
end

always_ff @(posedge clk or posedge areset) begin
    if (areset)
        state <= 2'b01;
    else
        state <= next_state;
end

endmodule
