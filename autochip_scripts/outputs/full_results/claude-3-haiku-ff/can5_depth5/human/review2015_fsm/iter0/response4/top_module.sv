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

parameter [3:0] IDLE = 4'b0000, DETECT = 4'b0001, SHIFT = 4'b0010, WAIT = 4'b0011, NOTIFY = 4'b0100;
reg [3:0] state, next_state;
reg [3:0] shift_count;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
        shift_count <= 4'b0;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    next_state = state;
    shift_ena = 1'b0;
    counting = 1'b0;
    done = 1'b0;

    case (state)
        IDLE: begin
            if (data == 1'b1) begin
                next_state = DETECT;
            end
        end
        DETECT: begin
            if (data == 1'b1 || data == 1'b0) begin
                if ({data, 3'b101} == 4'b1101) begin
                    next_state = SHIFT;
                    shift_count = 4'b0000;
                end
                else begin
                    next_state = IDLE;
                end
            end
        end
        SHIFT: begin
            shift_ena = 1'b1;
            if (shift_count == 4'b0100) begin
                next_state = WAIT;
            end
            else begin
                shift_count = shift_count + 1'b1;
            end
        end
        WAIT: begin
            counting = 1'b1;
            if (done_counting) begin
                next_state = NOTIFY;
            end
        end
        NOTIFY: begin
            done = 1'b1;
            if (ack) begin
                next_state = IDLE;
            end
        end
    endcase
end

endmodule
