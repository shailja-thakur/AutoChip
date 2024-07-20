module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

// Define the state values
localparam STATE_0 = 2'b00;
localparam STATE_1 = 2'b01;
localparam STATE_2 = 2'b10;
localparam STATE_3 = 2'b11;

always_ff @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= STATE_1;
    end
    else if (train_valid) begin
        if (train_taken && state < STATE_3) begin
            state <= state + 1'b1;
        end
        else if (!train_taken && state > STATE_0) begin
            state <= state - 1'b1;
        end
        // else, state remains unchanged
    end
    // else, state remains unchanged
end

endmodule
