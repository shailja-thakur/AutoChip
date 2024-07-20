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
    if (areset) begin
        next_state = 2'b01; // weakly not-taken
    end
    else if (train_valid) begin
        if (train_taken) begin
            if (state != 2'b11) // check for max value of 3
                next_state = state + 1'b1;
        end
        else begin
            if (state != 2'b00) // check for min value of 0
                next_state = state - 1'b1;
        end
    end
end

always_ff @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= 2'b01;
    end
    else begin
        state <= next_state;
    end
end

endmodule
