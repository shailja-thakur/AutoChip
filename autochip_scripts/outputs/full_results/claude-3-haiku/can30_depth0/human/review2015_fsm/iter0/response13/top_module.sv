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

reg [3:0] state;
parameter [3:0] 
    WAIT_START = 4'd0,
    SHIFT_PATTERN = 4'd1,
    SHIFT_DURATION = 4'd2,
    COUNT = 4'd3,
    NOTIFY = 4'd4,
    WAIT_ACK = 4'd5;

reg [3:0] pattern;
reg [3:0] duration;
reg [3:0] count;

always @(posedge clk) begin
    if (reset) begin
        state <= WAIT_START;
        pattern <= 4'b0000;
        duration <= 4'b0000;
        count <= 4'b0000;
        shift_ena <= 1'b0;
        counting <= 1'b0;
        done <= 1'b0;
    end else begin
        case (state)
            WAIT_START: begin
                if (pattern == 4'b1101) begin
                    state <= SHIFT_PATTERN;
                    pattern <= 4'b0000;
                end else begin
                    pattern <= {pattern[2:0], data};
                end
            end
            SHIFT_PATTERN: begin
                shift_ena <= 1'b1;
                if (count == 4'd3) begin
                    shift_ena <= 1'b0;
                    state <= SHIFT_DURATION;
                    count <= 4'b0000;
                end else begin
                    count <= count + 1;
                end
            end
            SHIFT_DURATION: begin
                if (count == 4'd3) begin
                    state <= COUNT;
                    counting <= 1'b1;
                    count <= 4'b0000;
                end else begin
                    duration[count] <= data;
                    count <= count + 1;
                end
            end
            COUNT: begin
                if (done_counting) begin
                    state <= NOTIFY;
                    counting <= 1'b0;
                    done <= 1'b1;
                end
            end
            NOTIFY: begin
                if (ack) begin
                    state <= WAIT_START;
                    done <= 1'b0;
                end
            end
            default: begin
                state <= WAIT_START;
            end
        endcase
    end
end

endmodule
