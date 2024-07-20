module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output reg [1:0] state
);

    // Define the states as local parameters
    localparam [1:0] STATE_0 = 2'b00;
    localparam [1:0] STATE_1 = 2'b01;
    localparam [1:0] STATE_2 = 2'b10;
    localparam [1:0] STATE_3 = 2'b11;

    // Process block triggered on positive edge of clock or asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            // Reset the state to STATE_1
            state <= STATE_1;
        end else if (train_valid) begin
            // State transition logic based on train_taken signal
            if (train_taken) begin
                // Move to next state if not already in STATE_3
                if (state < STATE_3) begin
                    state <= state + 1;
                end
            end else begin
                // Move to previous state if not already in STATE_0
                if (state > STATE_0) begin
                    state <= state - 1;
                end
            end
        end
    end

endmodule
