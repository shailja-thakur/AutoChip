module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

// Define the states of the finite state machine
localparam STATE_ZERO = 3'b000;
localparam STATE_ONE  = 3'b001;
localparam STATE_TWO  = 3'b010;
localparam STATE_THREE= 3'b011;
localparam STATE_FOUR = 3'b100;
localparam STATE_FIVE = 3'b101;
localparam STATE_SIX  = 3'b110;
localparam STATE_ERROR= 3'b111;

// Declare the current and next state registers
reg [2:0] current_state, next_state;

// State transition logic
always @(posedge clk) begin
    if (reset) begin
        current_state <= STATE_ZERO;
    end else begin
        current_state <= next_state;
    end
end

// Next state and output logic
always @(*) begin
    // Default outputs
    disc = 0;
    flag = 0;
    err = 0;

    // Next state and output logic
    case (current_state)
        STATE_ZERO: begin
            if (in == 0) begin
                next_state = STATE_ONE;
            end else begin
                next_state = STATE_ZERO;
            end
        end
        STATE_ONE: begin
            if (in == 1) begin
                next_state = STATE_TWO;
            end else begin
                next_state = STATE_ZERO;
            end
        end
        STATE_TWO: begin
            if (in == 1) begin
                next_state = STATE_THREE;
            end else begin
                next_state = STATE_ZERO;
            end
        end
        STATE_THREE: begin
            if (in == 1) begin
                next_state = STATE_FOUR;
            end else begin
                next_state = STATE_ZERO;
            end
        end
        STATE_FOUR: begin
            if (in == 1) begin
                next_state = STATE_FIVE;
            end else begin
                next_state = STATE_ZERO;
            end
        end
        STATE_FIVE: begin
            if (in == 1) begin
                next_state = STATE_SIX;
                disc = 1;
            end else begin
                next_state = STATE_ZERO;
            end
        end
        STATE_SIX: begin
            if (in == 1) begin
                next_state = STATE_ERROR;
                err = 1;
            end else begin
                next_state = STATE_ZERO;
                flag = 1;
            end
        end
        STATE_ERROR: begin
            if (in == 0) begin
                next_state = STATE_ZERO;
            end else begin
                next_state = STATE_ERROR;
            end
        end
        default: begin
            next_state = STATE_ZERO;
        end
    endcase
end

endmodule
