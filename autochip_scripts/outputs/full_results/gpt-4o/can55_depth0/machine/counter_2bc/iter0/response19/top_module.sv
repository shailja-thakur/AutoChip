module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output reg [1:0] state
);
    // Define the states
    localparam STATE_0 = 2'b00;
    localparam STATE_1 = 2'b01;
    localparam STATE_2 = 2'b10;
    localparam STATE_3 = 2'b11;

    // Asynchronous reset logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= STATE_1; // Reset to state 1
        end else if (train_valid) begin
            // State transition logic
            case (state)
                STATE_0: state <= (train_taken) ? STATE_1 : STATE_0;
                STATE_1: state <= (train_taken) ? STATE_2 : (train_taken == 0 && state > STATE_0) ? STATE_0 : state;
                STATE_2: state <= (train_taken) ? STATE_3 : STATE_1;
                STATE_3: state <= (train_taken) ? STATE_3 : STATE_2;
                default: state <= STATE_1; // Default state
            endcase
        end
    end
endmodule
