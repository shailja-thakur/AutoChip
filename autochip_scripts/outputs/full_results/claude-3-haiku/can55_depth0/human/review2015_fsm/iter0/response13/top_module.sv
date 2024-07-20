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

localparam [3:0] SEARCH = 4'b0000, 
                 DETECT = 4'b0001,
                 SHIFT  = 4'b0010,
                 COUNT  = 4'b0011,
                 NOTIFY = 4'b0100,
                 WAIT   = 4'b0101;

reg [3:0] state, next_state;
reg [3:0] pattern;

always @(posedge clk) begin
    if (reset) begin
        state <= SEARCH;
        pattern <= 4'b0000;
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
        SEARCH: begin
            if (pattern == 4'b1101) begin
                next_state = DETECT;
            end
        end
        DETECT: begin
            shift_ena = 1'b1;
            next_state = SHIFT;
        end
        SHIFT: begin
            shift_ena = 1'b1;
            if (pattern[3:0] == 4'b0000) begin
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
            next_state = WAIT;
        end
        WAIT: begin
            if (ack) begin
                next_state = SEARCH;
            end
        end
        default: begin
            next_state = SEARCH;
        end
    endcase
end

endmodule
