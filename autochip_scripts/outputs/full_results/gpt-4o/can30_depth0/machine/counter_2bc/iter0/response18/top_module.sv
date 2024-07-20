module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output reg [1:0] state
);

    // State encoding
    localparam STATE_0 = 2'b00;
    localparam STATE_1 = 2'b01;
    localparam STATE_2 = 2'b10;
    localparam STATE_3 = 2'b11;

    // Combinational logic to determine next state
    reg [1:0] next_state;

    always @(*) begin
        next_state = state; // Default to no state change
        if (train_valid) begin
            if (train_taken) begin
                if (state < STATE_3) begin
                    next_state = state + 1;
                end
            end else begin
                if (state > STATE_0) begin
                    next_state = state - 1;
                end
            end
        end
    end

    // Synchronous state update with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= STATE_1;
        end else begin
            state <= next_state;
        end
    end

endmodule
