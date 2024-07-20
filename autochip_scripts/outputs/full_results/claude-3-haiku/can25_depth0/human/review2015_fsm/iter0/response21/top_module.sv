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

parameter IDLE = 3'b000;
parameter DETECT_START = 3'b001;
parameter SHIFT_DURATION = 3'b010;
parameter COUNTING = 3'b011;
parameter NOTIFY = 3'b100;

reg [2:0] state;
reg [3:0] shift_count;

always @(posedge clk, posedge reset) begin
    if (reset) begin
        state <= IDLE;
        shift_ena <= 0;
        counting <= 0;
        done <= 0;
        shift_count <= 0;
    end
    else begin
        case (state)
            IDLE: begin
                if (data == 1'b1) begin
                    state <= DETECT_START;
                end
                else begin
                    state <= IDLE;
                end
            end
            DETECT_START: begin
                if (data == 1'b1) begin
                    state <= DETECT_START;
                end
                else if (data == 1'b0) begin
                    state <= SHIFT_DURATION;
                    shift_count <= 0;
                    shift_ena <= 1;
                end
            end
            SHIFT_DURATION: begin
                if (shift_count == 4'd3) begin
                    shift_ena <= 0;
                    counting <= 1;
                    state <= COUNTING;
                end
                else begin
                    shift_count <= shift_count + 1;
                end
            end
            COUNTING: begin
                if (done_counting) begin
                    counting <= 0;
                    done <= 1;
                    state <= NOTIFY;
                end
            end
            NOTIFY: begin
                if (ack) begin
                    done <= 0;
                    state <= IDLE;
                end
            end
        endcase
    end
end

endmodule
