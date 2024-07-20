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

parameter WAIT_FOR_START = 0;
parameter SHIFT_DURATION = 1;
parameter WAIT_FOR_DONE = 2;
parameter WAIT_FOR_ACK = 3;

reg [1:0] state, next_state;
reg [3:0] shift_count;

always @(posedge clk) begin
    if (reset) begin
        state <= WAIT_FOR_START;
        shift_count <= 0;
        shift_ena <= 0;
        counting <= 0;
        done <= 0;
    end
    else begin
        state <= next_state;
        case (state)
            WAIT_FOR_START: begin
                if (data == 1 && shift_count == 0) shift_count <= 1;
                else if (data == 0 && shift_count == 1) shift_count <= 2;
                else if (data == 1 && shift_count == 2) shift_count <= 3;
                else if (data == 1 && shift_count == 3) begin
                    shift_count <= 0;
                    next_state <= SHIFT_DURATION;
                end
                else shift_count <= 0;
            end
            SHIFT_DURATION: begin
                shift_ena <= 1;
                if (shift_count < 4) shift_count <= shift_count + 1;
                else begin
                    shift_ena <= 0;
                    next_state <= WAIT_FOR_DONE;
                end
            end
            WAIT_FOR_DONE: begin
                counting <= 1;
                if (done_counting) begin
                    counting <= 0;
                    next_state <= WAIT_FOR_ACK;
                    done <= 1;
                end
            end
            WAIT_FOR_ACK: begin
                if (ack) begin
                    done <= 0;
                    next_state <= WAIT_FOR_START;
                end
            end
        endcase
    end
end

endmodule
