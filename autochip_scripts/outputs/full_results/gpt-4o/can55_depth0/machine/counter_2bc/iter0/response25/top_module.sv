module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

// State encoding
localparam [1:0] STATE_0 = 2'd0;
localparam [1:0] STATE_1 = 2'd1;
localparam [1:0] STATE_2 = 2'd2;
localparam [1:0] STATE_3 = 2'd3;

logic [1:0] next_state;

always_ff @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= STATE_1;
    end else begin
        state <= next_state;
    end
end

always_comb begin
    next_state = state; // Default assignment to hold the state
    if (train_valid) begin
        if (train_taken && state < STATE_3) begin
            next_state = state + 2'd1;
        end else if (!train_taken && state > STATE_0) begin
            next_state = state - 2'd1;
        end
    end
end

endmodule
