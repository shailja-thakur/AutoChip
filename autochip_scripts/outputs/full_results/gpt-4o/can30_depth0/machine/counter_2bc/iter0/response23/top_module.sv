module top_module (
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output reg [1:0] state
);

    // State encoding
    parameter S0 = 2'b00;
    parameter S1 = 2'b01;
    parameter S2 = 2'b10;
    parameter S3 = 2'b11;

    // State transition logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= S1;
        end else if (train_valid) begin
            if (train_taken && state < S3) begin
                state <= state + 1;
            end else if (!train_taken && state > S0) begin
                state <= state - 1;
            end
        end
    end

endmodule
