module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output reg [1:0] state
);

    // State encoding
    localparam [1:0]
        STATE_0 = 2'b00,
        STATE_1 = 2'b01,
        STATE_2 = 2'b10,
        STATE_3 = 2'b11;

    // Sequential logic for state transitions
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            // Asynchronous reset
            state <= STATE_1;
        end else if (train_valid) begin
            if (train_taken) begin
                if (state < STATE_3) begin
                    state <= state + 1'b1;
                end else begin
                    state <= state; // Remain in the current state
                end
            end else begin
                if (state > STATE_0) begin
                    state <= state - 1'b1;
                end else begin
                    state <= state; // Remain in the current state
                end
            end
        end
    end

endmodule
