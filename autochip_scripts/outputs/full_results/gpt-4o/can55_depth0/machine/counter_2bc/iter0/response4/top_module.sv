module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output reg [1:0] state
);
    
    // Define state encoding
    localparam STATE_0 = 2'b00;
    localparam STATE_1 = 2'b01;
    localparam STATE_2 = 2'b10;
    localparam STATE_3 = 2'b11;

    // Sequential always block to update state
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            // Asynchronous reset to state 1
            state <= STATE_1;
        end else if (train_valid) begin
            if (train_taken) begin
                // Move to the next state if train_taken is asserted and the state is less than 3
                if (state < STATE_3)
                    state <= state + 2'b01;
            end else begin
                // Move to the previous state if train_taken is not asserted and the state is greater than 0
                if (state > STATE_0)
                    state <= state - 2'b01;
            end
        end
    end
endmodule
