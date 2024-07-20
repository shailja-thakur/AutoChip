module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    always_ff @(posedge clk or posedge areset)
    if (areset) begin
        state <= 2'b01;  // reset to weakly not-taken
    end else if (train_valid == 1'b1) begin
        if (train_taken == 1'b1 && state < 2'b11) begin
            state <= state + 1;  // increment when train_valid = 1 and train_taken = 1
        end else if (train_taken == 1'b0 && state > 2'b00) begin
            state <= state - 1;  // decrement when train_valid = 1 and train_taken = 0
        end
    end

endmodule
