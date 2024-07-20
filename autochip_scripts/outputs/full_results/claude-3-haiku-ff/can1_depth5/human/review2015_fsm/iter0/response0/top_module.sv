module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack
);

localparam [2:0] 
    IDLE = 3'b000,
    DETECT_START = 3'b001,
    SHIFT_IN_DURATION = 3'b010,
    WAIT_FOR_TIMER = 3'b011,
    NOTIFY_USER = 3'b100;

reg [2:0] state, next_state;
reg [3:0] shift_reg;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        shift_reg <= 4'b0;
    end
    else begin
        state <= next_state;
        shift_reg <= {shift_reg[2:0], data};
    end
end

always @(*) begin
    next_state = state;
    shift_ena = 0;
    counting = 0;
    done = 0;
    case (state)
        IDLE: begin
            if (shift_reg == 4'b1101) begin
                next_state = DETECT_START;
            end
        end
        DETECT_START: begin
            shift_ena = 1;
            next_state = SHIFT_IN_DURATION;
        end
        SHIFT_IN_DURATION: begin
            shift_ena = 1;
            if (shift_reg[3:0] == 4'b0000) begin
                next_state = WAIT_FOR_TIMER;
            end
        end
        WAIT_FOR_TIMER: begin
            counting = 1;
            if (done_counting) begin
                next_state = NOTIFY_USER;
            end
        end
        NOTIFY_USER: begin
            done = 1;
            if (ack) begin
                next_state = IDLE;
            end
        end
    endcase
end

endmodule
