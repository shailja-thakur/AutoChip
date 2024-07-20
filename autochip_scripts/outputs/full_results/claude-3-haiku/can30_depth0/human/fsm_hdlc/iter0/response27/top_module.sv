module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

// Define the states of the finite state machine
localparam STATE_ZERO = 0, STATE_ONE = 1, STATE_TWO = 2, STATE_THREE = 3, STATE_FOUR = 4, STATE_FIVE = 5, STATE_SIX = 6, STATE_SEVEN = 7;

// Declare the current and next state registers
reg [2:0] current_state, next_state;

always @(posedge clk) begin
    if (reset) begin
        current_state <= STATE_ZERO;
        disc <= 0;
        flag <= 0;
        err <= 0;
    end
    else begin
        current_state <= next_state;
        
        // Assign the output signals based on the current state
        case (current_state)
            STATE_ZERO: begin
                disc <= 0;
                flag <= 0;
                err <= 0;
            end
            STATE_ONE: begin
                disc <= 0;
                flag <= 0;
                err <= 0;
            end
            STATE_TWO: begin
                disc <= 0;
                flag <= 0;
                err <= 0;
            end
            STATE_THREE: begin
                disc <= 0;
                flag <= 0;
                err <= 0;
            end
            STATE_FOUR: begin
                disc <= 0;
                flag <= 0;
                err <= 0;
            end
            STATE_FIVE: begin
                disc <= 1;
                flag <= 0;
                err <= 0;
            end
            STATE_SIX: begin
                disc <= 0;
                flag <= 1;
                err <= 0;
            end
            STATE_SEVEN: begin
                disc <= 0;
                flag <= 0;
                err <= 1;
            end
        endcase
    end
end

// Update the next state based on the current state and the input
always @(*) begin
    case (current_state)
        STATE_ZERO: next_state = (in == 0) ? STATE_ONE : STATE_ZERO;
        STATE_ONE: next_state = (in == 0) ? STATE_TWO : STATE_ZERO;
        STATE_TWO: next_state = (in == 0) ? STATE_THREE : STATE_ZERO;
        STATE_THREE: next_state = (in == 0) ? STATE_FOUR : STATE_ZERO;
        STATE_FOUR: next_state = (in == 0) ? STATE_FIVE : STATE_ZERO;
        STATE_FIVE: next_state = (in == 0) ? STATE_ZERO : STATE_SIX;
        STATE_SIX: next_state = (in == 0) ? STATE_ZERO : STATE_SEVEN;
        STATE_SEVEN: next_state = (in == 0) ? STATE_ZERO : STATE_SEVEN;
    endcase
end

endmodule
