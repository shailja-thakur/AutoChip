module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output reg [1:0] state
);

    // State encoding
    localparam S0 = 2'b00;
    localparam S1 = 2'b01;
    localparam S2 = 2'b10;
    localparam S3 = 2'b11;

    // Initial state
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= S1; // Reset to state 1
        end else if (train_valid) begin
            if (train_taken) begin
                if (state < S3) begin
                    state <= state + 1;
                end
            end else begin
                if (state > S0) begin
                    state <= state - 1;
                end
            end
        end
    end

endmodule
