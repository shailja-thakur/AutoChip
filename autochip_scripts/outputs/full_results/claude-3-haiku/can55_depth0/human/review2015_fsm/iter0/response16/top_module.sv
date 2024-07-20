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

parameter WAIT_PATTERN = 2'b00,
          SHIFT_BITS   = 2'b01,
          COUNT        = 2'b10,
          DONE         = 2'b11;

reg [1:0] state, next_state;
reg [3:0] pattern;

always @(posedge clk) begin
    if (reset) begin
        state <= WAIT_PATTERN;
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
        WAIT_PATTERN: begin
            if (pattern == 4'b1101) begin
                next_state = SHIFT_BITS;
                shift_ena = 1'b1;
            end
        end
        SHIFT_BITS: begin
            shift_ena = 1'b1;
            if (pattern[3:0] == 4'b1111) begin
                next_state = COUNT;
                counting = 1'b1;
            end
        end
        COUNT: begin
            counting = 1'b1;
            if (done_counting) begin
                next_state = DONE;
                done = 1'b1;
            end
        end
        DONE: begin
            if (ack) begin
                next_state = WAIT_PATTERN;
            end
        end
    endcase
end

endmodule
