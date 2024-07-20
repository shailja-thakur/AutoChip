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

localparam [2:0] WAIT_FOR_START = 3'd0,
                 SHIFT_DURATION = 3'd1,
                 COUNTING       = 3'd2,
                 NOTIFY_USER    = 3'd3;

reg [2:0] state, next_state;
reg [3:0] shift_count;

always @(posedge clk) begin
    if (reset) begin
        state <= WAIT_FOR_START;
        shift_count <= 4'b0;
    end
    else begin
        state <= next_state;
        shift_count <= (next_state == SHIFT_DURATION) ? shift_count + 1 : 4'b0;
    end
end

always @(*) begin
    next_state = state;
    shift_ena = 1'b0;
    counting = 1'b0;
    done = 1'b0;

    case (state)
        WAIT_FOR_START: begin
            if (data == 1'b1 && data_history == 4'b1101) begin
                next_state = SHIFT_DURATION;
                shift_ena = 1'b1;
            end
        end

        SHIFT_DURATION: begin
            shift_ena = 1'b1;
            if (shift_count == 4'b1111) begin
                next_state = COUNTING;
            end
        end

        COUNTING: begin
            counting = 1'b1;
            if (done_counting) begin
                next_state = NOTIFY_USER;
            end
        end

        NOTIFY_USER: begin
            done = 1'b1;
            if (ack) begin
                next_state = WAIT_FOR_START;
            end
        end
    endcase
end

reg [3:0] data_history;

always @(posedge clk) begin
    if (reset) begin
        data_history <= 4'b0;
    end
    else begin
        data_history <= {data_history[2:0], data};
    end
end

endmodule
