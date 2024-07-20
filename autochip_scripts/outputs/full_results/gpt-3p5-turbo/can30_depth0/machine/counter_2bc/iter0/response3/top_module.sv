module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output  reg [1:0] state
);

always @(posedge clk or negedge areset) begin
    if (areset == 0) begin
        state <= 2'b01;
    end else begin
        if (train_valid) begin
            if (train_taken && state < 2'b11) begin
                state <= state + 2'b01;
            end else if (!train_taken && state > 2'b00) begin
                state <= state - 2'b01;
            end
        end
    end
end

endmodule
