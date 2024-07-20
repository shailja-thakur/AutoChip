module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

// Define the states
localparam [2:0] IDLE  = 3'b000,
                 ONE   = 3'b001,
                 TWO   = 3'b010,
                 THREE = 3'b011,
                 FOUR  = 3'b100,
                 FIVE  = 3'b101,
                 SIX   = 3'b110,
                 SEVEN = 3'b111;

reg [2:0] state, next_state;

// Next state logic
always @(*) begin
    case (state)
        IDLE: next_state = in ? ONE   : IDLE;
        ONE:  next_state = in ? TWO   : IDLE;
        TWO:  next_state = in ? THREE : IDLE;
        THREE:next_state = in ? FOUR  : IDLE;
        FOUR: next_state = in ? FIVE  : IDLE;
        FIVE: next_state = in ? SIX   : IDLE;
        SIX:  next_state = in ? SEVEN : IDLE;
        SEVEN:next_state = in ? SEVEN : IDLE;
    endcase
end

// Output logic
always @(*) begin
    disc = 0;
    flag = 0;
    err = 0;
    case (state)
        SIX:  disc = 1;
        SEVEN:err = 1;
        IDLE, SIX: flag = 1;
    endcase
end

// State register
always @(posedge clk) begin
    if (reset)
        state <= IDLE;
    else
        state <= next_state;
end

endmodule
