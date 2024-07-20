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

localparam WAIT_START = 0, SHIFT_BITS = 1, WAIT_DONE = 2, WAIT_ACK = 3;
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
        case (state)
            WAIT_START: begin
                if (data == 1'b1) begin
                    if (shift_count == 4'b0001) begin
                        next_state <= SHIFT_BITS;
                        shift_count <= 0;
                    end
                    else begin
                        shift_count <= shift_count + 1;
                    end
                end
                else begin
                    shift_count <= 0;
                end
                shift_ena <= 0;
                counting <= 0;
                done <= 0;
            end
            SHIFT_BITS: begin
                if (shift_count == 4'b0100) begin
                    next_state <= WAIT_DONE;
                    shift_count <= 0;
                end
                else begin
                    shift_count <= shift_count + 1;
                end
                shift_ena <= 1;
                counting <= 0;
                done <= 0;
            end
            WAIT_DONE: begin
                if (done_counting) begin
                    next_state <= WAIT_ACK;
                    shift_ena <= 0;
                    counting <= 0;
                    done <= 1;
                end
                else begin
                    shift_ena <= 0;
                    counting <= 1;
                    done <= 0;
                end
            end
            WAIT_ACK: begin
                if (ack) begin
                    next_state <= WAIT_START;
                    shift_ena <= 0;
                    counting <= 0;
                    done <= 0;
                end
                else begin
                    shift_ena <= 0;
                    counting <= 0;
                    done <= 1;
                end
            end
        endcase
    end
end

endmodule
