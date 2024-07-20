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

localparam [1:0] WAIT_START = 2'b00,
                 SHIFT_DURATION = 2'b01,
                 COUNT = 2'b10,
                 NOTIFY = 2'b11;

reg [1:0] state, next_state;
reg [3:0] shift_count;

always @(posedge clk) begin
    if (reset) begin
        state <= WAIT_START;
        shift_count <= 0;
        shift_ena <= 0;
        counting <= 0;
        done <= 0;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    next_state = state;
    case (state)
        WAIT_START: begin
            shift_ena = 0;
            counting = 0;
            done = 0;
            if (data == 1'b1 && {data, data, data, data} == 4'b1101) begin
                next_state = SHIFT_DURATION;
                shift_count = 0;
            end
        end
        SHIFT_DURATION: begin
            shift_ena = 1;
            counting = 0;
            done = 0;
            if (shift_count == 4'd4) begin
                next_state = COUNT;
            end
            else begin
                shift_count = shift_count + 1;
            end
        end
        COUNT: begin
            shift_ena = 0;
            counting = 1;
            done = 0;
            if (done_counting) begin
                next_state = NOTIFY;
            end
        end
        NOTIFY: begin
            shift_ena = 0;
            counting = 0;
            done = 1;
            if (ack) begin
                next_state = WAIT_START;
            end
        end
    endcase
end

endmodule
