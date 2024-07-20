module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output reg [1:0] state
);

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b01;  // Reset to state 1
        end
        else if (train_valid) begin
            if (train_taken) begin
                if (state < 2'b11) begin
                    state <= state + 2'b01;  // Go to the next state if train_taken is asserted and state < 3
                end
            end
            else begin
                if (state > 2'b00) begin
                    state <= state - 2'b01;  // Go to the previous state if train_taken is not asserted and state > 0
                end
            end
        end
    end

endmodule
