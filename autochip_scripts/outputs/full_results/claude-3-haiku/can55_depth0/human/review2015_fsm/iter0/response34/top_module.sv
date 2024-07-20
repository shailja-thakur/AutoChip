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

parameter IDLE = 3'b000, DETECT = 3'b001, SHIFT = 3'b010, COUNT = 3'b011, NOTIFY = 3'b100;
reg [2:0] state, next_state;
reg [3:0] shift_count;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        shift_count <= 4'b0;
        shift_ena <= 1'b0;
        counting <= 1'b0;
        done <= 1'b0;
    end else begin
        state <= next_state;
        case (state)
            IDLE: begin
                shift_ena <= 1'b0;
                counting <= 1'b0;
                done <= 1'b0;
                if (data == 1'b1) begin
                    next_state <= DETECT;
                end else begin
                    next_state <= IDLE;
                end
            end
            DETECT: begin
                if (data == 1'b1) begin
                    next_state <= DETECT;
                end else if (data == 1'b0) begin
                    next_state <= SHIFT;
                    shift_count <= 4'b0;
                end else begin
                    next_state <= IDLE;
                end
            end
            SHIFT: begin
                shift_ena <= 1'b1;
                shift_count <= shift_count + 4'b1;
                if (shift_count == 4'b0100) begin
                    next_state <= COUNT;
                    shift_ena <= 1'b0;
                end else begin
                    next_state <= SHIFT;
                end
            end
            COUNT: begin
                counting <= 1'b1;
                if (done_counting) begin
                    next_state <= NOTIFY;
                    counting <= 1'b0;
                end else begin
                    next_state <= COUNT;
                end
            end
            NOTIFY: begin
                done <= 1'b1;
                if (ack) begin
                    next_state <= IDLE;
                    done <= 1'b0;
                end else begin
                    next_state <= NOTIFY;
                end
            end
            default: begin
                next_state <= IDLE;
            end
        endcase
    end
end

endmodule
