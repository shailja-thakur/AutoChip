module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

// Define the states of the finite state machine
localparam [2:0] 
    IDLE = 3'b000,
    WAIT_ONE = 3'b001,
    WAIT_TWO = 3'b010,
    WAIT_THREE = 3'b011,
    WAIT_FOUR = 3'b100,
    WAIT_FIVE = 3'b101,
    WAIT_SIX = 3'b110,
    ERROR = 3'b111;

reg [2:0] state, next_state;

// State transition logic
always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
    end else begin
        state <= next_state;
    end
end

always @(*) begin
    next_state = state;
    disc = 1'b0;
    flag = 1'b0;
    err = 1'b0;

    case (state)
        IDLE: begin
            if (in) begin
                next_state = WAIT_ONE;
            end
        end
        WAIT_ONE: begin
            if (in) begin
                next_state = WAIT_TWO;
            end else begin
                next_state = IDLE;
            end
        end
        WAIT_TWO: begin
            if (in) begin
                next_state = WAIT_THREE;
            end else begin
                next_state = IDLE;
            end
        end
        WAIT_THREE: begin
            if (in) begin
                next_state = WAIT_FOUR;
            end else begin
                next_state = IDLE;
            end
        end
        WAIT_FOUR: begin
            if (in) begin
                next_state = WAIT_FIVE;
            end else begin
                next_state = IDLE;
            end
        end
        WAIT_FIVE: begin
            if (in) begin
                next_state = WAIT_SIX;
            end else begin
                next_state = IDLE;
            end
        end
        WAIT_SIX: begin
            if (in) begin
                next_state = ERROR;
                err = 1'b1;
            end else begin
                next_state = IDLE;
                disc = 1'b1;
                flag = 1'b1;
            end
        end
        ERROR: begin
            if (in) begin
                next_state = ERROR;
                err = 1'b1;
            end else begin
                next_state = IDLE;
            end
        end
    endcase
end

endmodule
