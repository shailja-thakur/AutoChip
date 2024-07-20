module top_module(
    input wire clk,
    input wire areset,
    input wire train_valid,
    input wire train_taken,
    output reg [1:0] state
);

    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= 1;
        else if (train_valid) begin
            if (train_taken && state < 3)
                state <= state + 1;
            else if (!train_taken && state > 0)
                state <= state - 1;
        end
    end

endmodule
