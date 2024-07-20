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

localparam [2:0] WAIT_START = 3'd0,
                 SHIFT_DURATION = 3'd1,
                 WAIT_COUNTING = 3'd2,
                 NOTIFY_COMPLETE = 3'd3,
                 WAIT_ACK = 3'd4;

reg [2:0] state, next_state;
reg [3:0] shift_count;

always @(posedge clk) begin
    if (reset) begin
        state <= WAIT_START;
        shift_count <= 4'b0;
        shift_ena <= 1'b0;
        counting <= 1'b0;
        done <= 1'b0;
    end
    else begin
        state <= next_state;
        case (state)
            WAIT_START: begin
                if (data == 1'b1 && shift_count == 4'b0) begin
                    shift_count <= 4'b1;
                end
                else if (data == 1'b1 && shift_count == 4'b1) begin
                    shift_count <= 4'b10;
                end
                else if (data == 1'b0 && shift_count == 4'b10) begin
                    shift_count <= 4'b11;
                end
                else if (data == 1'b1 && shift_count == 4'b11) begin
                    shift_count <= 4'b0;
                    next_state <= SHIFT_DURATION;
                end
                else begin
                    shift_count <= 4'b0;
                end
            end
            SHIFT_DURATION: begin
                shift_ena <= 1'b1;
                if (shift_count == 4'b0100) begin
                    shift_ena <= 1'b0;
                    next_state <= WAIT_COUNTING;
                end
                else begin
                    shift_count <= shift_count + 1'b1;
                end
            end
            WAIT_COUNTING: begin
                counting <= 1'b1;
                if (done_counting) begin
                    counting <= 1'b0;
                    next_state <= NOTIFY_COMPLETE;
                end
            end
            NOTIFY_COMPLETE: begin
                done <= 1'b1;
                next_state <= WAIT_ACK;
            end
            WAIT_ACK: begin
                if (ack) begin
                    done <= 1'b0;
                    next_state <= WAIT_START;
                end
            end
            default: next_state <= WAIT_START;
        endcase
    end
end

endmodule
