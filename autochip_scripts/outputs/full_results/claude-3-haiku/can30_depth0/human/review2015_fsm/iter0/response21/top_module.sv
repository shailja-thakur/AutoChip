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

reg [3:0] state, next_state;
reg [3:0] shift_reg;

localparam IDLE = 4'd0,
          DETECT_PATTERN = 4'd1,
          SHIFT_DURATION = 4'd2,
          COUNT = 4'd3,
          NOTIFY = 4'd4,
          WAIT_ACK = 4'd5;

always @(posedge clk or posedge reset) begin
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
    shift_ena = 1'b0;
    counting = 1'b0;
    done = 1'b0;
    case (state)
        IDLE: begin
            if (shift_reg == 4'b1101) begin
                next_state = DETECT_PATTERN;
            end
        end
        DETECT_PATTERN: begin
            shift_ena = 1'b1;
            next_state = SHIFT_DURATION;
        end
        SHIFT_DURATION: begin
            shift_ena = 1'b1;
            if (shift_reg[3:0] == 4'b1111) begin
                next_state = COUNT;
            end
        end
        COUNT: begin
            counting = 1'b1;
            if (done_counting) begin
                next_state = NOTIFY;
            end
        end
        NOTIFY: begin
            done = 1'b1;
            next_state = WAIT_ACK;
        end
        WAIT_ACK: begin
            if (ack) begin
                next_state = IDLE;
            end
        end
    endcase
end

endmodule
