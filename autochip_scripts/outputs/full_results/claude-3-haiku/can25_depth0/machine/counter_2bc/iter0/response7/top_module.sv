module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

logic [1:0] next_state;

always_comb begin
    // Default next state is to stay in the current state
    next_state = state;

    // Asynchronous reset
    if (areset) begin
        next_state = 2'b01;
    end
    // Transition logic based on input signals
    else if (train_valid) begin
        if (train_taken && state < 2'b11) begin
            next_state = state + 1'b1;
        end
        else if (!train_taken && state > 2'b00) begin
            next_state = state - 1'b1;
        end
    end
end

always_ff @(posedge clk) begin
    state <= next_state;
end

endmodule
