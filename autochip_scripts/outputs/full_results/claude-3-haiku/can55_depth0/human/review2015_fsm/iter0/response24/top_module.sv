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
    WAIT_START = 3'd0,
    SHIFT_BITS = 3'd1,
    WAIT_DONE  = 3'd2,
    WAIT_ACK   = 3'd3;

reg [2:0] state, next_state;
reg [3:0] pattern;

always @(posedge clk) begin
    if (reset) begin
        state <= WAIT_START;
        pattern <= 4'b0;
    end
    else begin
        state <= next_state;
        pattern <= {pattern[2:0], data};
    end
end

always @(*) begin
    next_state = state;
    shift_ena = 1'b0;
    counting = 1'b0;
    done = 1'b0;

    case (state)
        WAIT_START: begin
            if (pattern == 4'b1101) begin
                next_state = SHIFT_BITS;
                shift_ena = 1'b1;
            end
        end
        SHIFT_BITS: begin
            shift_ena = 1'b1;
            if (pattern[3:0] == 4'b1111) begin
                next_state = WAIT_DONE;
                counting = 1'b1;
            end
        end
        WAIT_DONE: begin
            counting = 1'b1;
            if (done_counting) begin
                next_state = WAIT_ACK;
                done = 1'b1;
            end
        end
        WAIT_ACK: begin
            if (ack) begin
                next_state = WAIT_START;
            end
        end
    endcase
end

endmodule
