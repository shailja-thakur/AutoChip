module top_module (
	input clk,
	input reset,
	input in,
	output reg disc,
	output reg flag,
	output reg err);

// State encoding
typedef enum reg [2:0] {
    S_IDLE = 3'b000,
    S_ONE = 3'b001,
    S_TWO = 3'b010,
    S_THREE = 3'b011,
    S_FOUR = 3'b100,
    S_FIVE = 3'b101,
    S_SIX = 3'b110,
    S_ERR = 3'b111
} state_t;

// State registers
state_t state, next_state;

// Next state logic
always @(*) begin
    next_state = state;
    disc = 0;
    flag = 0;
    err = 0;
    case (state)
        S_IDLE: begin
            if (in) next_state = S_ONE;
            else next_state = S_IDLE;
        end
        S_ONE: begin
            if (in) next_state = S_TWO;
            else next_state = S_IDLE;
        end
        S_TWO: begin
            if (in) next_state = S_THREE;
            else next_state = S_IDLE;
        end
        S_THREE: begin
            if (in) next_state = S_FOUR;
            else next_state = S_IDLE;
        end
        S_FOUR: begin
            if (in) next_state = S_FIVE;
            else next_state = S_IDLE;
        end
        S_FIVE: begin
            if (in) next_state = S_SIX;
            else begin
                next_state = S_IDLE;
                disc = 1;
            end
        end
        S_SIX: begin
            if (in) next_state = S_ERR;
            else begin
                next_state = S_IDLE;
                flag = 1;
            end
        end
        S_ERR: begin
            if (in) err = 1;
            else next_state = S_IDLE;
        end
        default: next_state = S_IDLE;
    endcase
end

// State register update
always @(posedge clk) begin
    if (reset)
        state <= S_IDLE;
    else
        state <= next_state;
end

endmodule
