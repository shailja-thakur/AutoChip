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
    START_DETECT = 3'b001,
    SHIFT_DURATION = 3'b010,
    COUNTING = 3'b011,
    WAIT_ACK = 3'b100;

reg [2:0] state, next_state;
reg [3:0] shift_count;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    next_state = state;
    shift_ena = 1'b0;
    counting = 1'b0;
    done = 1'b0;
    case (state)
        IDLE: begin
            if (data == 1'b1) begin
                next_state = START_DETECT;
            end
        end
        START_DETECT: begin
            if (data == 1'b1) begin
                next_state = START_DETECT;
            end
            else if (data == 1'b0) begin
                shift_count = 4'b0;
                next_state = SHIFT_DURATION;
            end
        end
        SHIFT_DURATION: begin
            shift_ena = 1'b1;
            shift_count = shift_count + 1'b1;
            if (shift_count == 4'b0100) begin
                next_state = COUNTING;
            end
            else begin
                next_state = SHIFT_DURATION;
            end
        end
        COUNTING: begin
            counting = 1'b1;
            if (done_counting) begin
                next_state = WAIT_ACK;
            end
        end
        WAIT_ACK: begin
            done = 1'b1;
            if (ack) begin
                next_state = IDLE;
            end
        end
    endcase
end

endmodule
