module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output reg [1:0] state
);

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b01; // weakly not-taken
        end
        else if (train_valid) begin
            if (train_taken) begin
                if (state < 2'b11) // Increment if state < 3
                    state <= state + 2'b01;
            end
            else begin
                if (state > 2'b00) // Decrement if state > 0
                    state <= state - 2'b01;
            end
        end
    end
endmodule
