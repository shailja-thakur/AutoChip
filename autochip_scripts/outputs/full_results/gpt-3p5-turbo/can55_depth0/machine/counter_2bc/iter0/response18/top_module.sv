module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output reg [1:0] state
);
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 1;
        end else if (train_valid) begin
            if (train_taken && state < 3) begin
                state <= state + 1;
            end else if (!train_taken && state > 0) begin
                state <= state - 1;
            end
        end
    end
    
endmodule
