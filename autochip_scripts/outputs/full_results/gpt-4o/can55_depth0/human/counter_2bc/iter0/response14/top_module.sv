module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output reg [1:0] state
);

    // Define the states of the counter
    localparam RESET_STATE = 2'b01;
    localparam MAX_STATE   = 2'b11;
    localparam MIN_STATE   = 2'b00;

    // Always block for the asynchronous reset and the state transitions based on clock
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= RESET_STATE;
        else if (train_valid) begin
            if (train_taken && state < MAX_STATE)
                state <= state + 1;
            else if (~train_taken && state > MIN_STATE)
                state <= state - 1;
        end
    end

endmodule
