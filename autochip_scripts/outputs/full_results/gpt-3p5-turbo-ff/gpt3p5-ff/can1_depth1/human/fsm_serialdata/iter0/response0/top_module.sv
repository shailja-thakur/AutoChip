module top_module (
    input clk,
    input in,
    input reset,
    output [7:0] out_byte,
    output done
);

// Define the states of the finite state machine
typedef enum logic [2:0] {
    IDLE,
    START_BIT,
    DATA_BIT_0,
    DATA_BIT_1,
    DATA_BIT_2,
    DATA_BIT_3,
    DATA_BIT_4,
    DATA_BIT_5,
    DATA_BIT_6,
    DATA_BIT_7,
    STOP_BIT
} state_type;

// Define the signals for the finite state machine
reg [2:0] state;
reg [7:0] data_byte;
reg stop_bit_found;
reg done_reg;

// Synchronous reset
always_ff @(posedge clk or posedge reset) begin
    if (reset)
        state <= IDLE;
    else
        state <= next_state;
end

// Next state logic
always_comb begin
    next_state = state;
    case (state)
        IDLE:
            if (in == 0)
                next_state = START_BIT;
        START_BIT:
            next_state = DATA_BIT_0;
        DATA_BIT_0, DATA_BIT_1, DATA_BIT_2, DATA_BIT_3, DATA_BIT_4, DATA_BIT_5, DATA_BIT_6:
            next_state = state + 1;
        DATA_BIT_7:
            next_state = STOP_BIT;
        STOP_BIT:
            if (in == 1)
                next_state = IDLE;
            else
                next_state = START_BIT;
    endcase
end

// Output data byte when done is 1
always_ff @(posedge clk) begin
    if (done_reg)
        out_byte <= data_byte;
    else
        out_byte <= 8'bzzzzzzzz;
end

// Done signal logic
always_ff @(posedge clk) begin
    if (state == STOP_BIT && in == 1)
        done_reg <= 1;
    else if (state == IDLE)
        done_reg <= 0;
end

endmodule
