module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b01;  // Reset to weakly not-taken
        end else if (train_valid) begin
            if (train_taken) begin
                state <= state + 1;  // Increment when train_valid = 1 and train_taken = 1
            end else begin
                state <= state - 1;  // Decrement when train_valid = 1 and train_taken = 0
            end
        end
    end
endmodule
