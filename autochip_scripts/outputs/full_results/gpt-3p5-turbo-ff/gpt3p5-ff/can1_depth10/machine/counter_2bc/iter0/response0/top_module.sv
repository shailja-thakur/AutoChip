module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

// define states using parameters
parameter STATE_0 = 2'b00;
parameter STATE_1 = 2'b01;
parameter STATE_2 = 2'b10;
parameter STATE_3 = 2'b11;

// state register
reg [1:0] current_state, next_state;

// synchronous reset to state 1
always_ff @(posedge clk or posedge areset)
    if (areset)
        current_state <= STATE_1;
    else
        current_state <= next_state;

// state transition logic
always_comb
    if (train_valid)
        if (train_taken && (current_state < STATE_3))
            next_state = current_state + 1;
        else if (!train_taken && (current_state > STATE_0))
            next_state = current_state - 1;
        else
            next_state = current_state;
    else
        next_state = current_state;

// assign state output
assign state = current_state;

endmodule
