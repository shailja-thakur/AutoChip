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

parameter WAIT_START = 3'b000;
parameter SHIFT_DURATION = 3'b001;
parameter WAIT_DONE = 3'b010;
parameter NOTIFY_USER = 3'b011;
parameter WAIT_ACK = 3'b100;

reg [2:0] state, next_state;
reg [3:0] shift_count;

always @(posedge clk) begin
    if (reset) begin
        state <= WAIT_START;
        shift_count <= 4'b0000;
        shift_ena <= 0;
        counting <= 0;
        done <= 0;
    end
    else begin
        state <= next_state;
        if (state == SHIFT_DURATION) begin
            shift_count <= shift_count - 1;
        end
    end
end

always @(*) begin
    next_state = state;
    shift_ena = 0;
    counting = 0;
    done = 0;
    case (state)
        WAIT_START: begin
            if ({shift_count[3:0], data} == 4'b1101) begin
                next_state = SHIFT_DURATION;
                shift_count <= 4'b0100;
            end
            else begin
                shift_count <= {shift_count[2:0], data};
            end
        end
        SHIFT_DURATION: begin
            shift_ena = 1;
            if (shift_count == 0) begin
                next_state = WAIT_DONE;
            end
        end
        WAIT_DONE: begin
            counting = 1;
            if (done_counting) begin
                next_state = NOTIFY_USER;
            end
        end
        NOTIFY_USER: begin
            done = 1;
            next_state = WAIT_ACK;
        end
        WAIT_ACK: begin
            if (ack) begin
                next_state = WAIT_START;
            end
        end
    endcase
end

endmodule
