module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output reg [1:0] state
);

// Define states
localparam STATE0 = 2'b00;
localparam STATE1 = 2'b01;
localparam STATE2 = 2'b10;
localparam STATE3 = 2'b11;

// State register
reg [1:0] current_state, next_state;

// Asynchronous reset and state update
always @(posedge clk or posedge areset) begin
    if (areset)
        current_state <= STATE1; // Reset to state 1
    else
        current_state <= next_state;
end

// Next state logic
always @(*) begin
    next_state = current_state; // Default next state is the current state

    if (train_valid) begin
        if (train_taken) begin
            if (current_state < STATE3)
                next_state = current_state + 1; // Move to the next state
        end else begin
            if (current_state > STATE0)
                next_state = current_state - 1; // Move to the previous state
        end
    end
end

// Output logic
assign state = current_state;

endmodule
