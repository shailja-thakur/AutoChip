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
    IDLE = 3'b000,
    DETECT_START = 3'b001,
    SHIFT_DURATION = 3'b010,
    COUNT = 3'b011,
    NOTIFY = 3'b100;

reg [2:0] state, next_state;
reg [3:0] shift_count;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
        shift_count <= 0;
        shift_ena <= 0;
        counting <= 0;
        done <= 0;
    end
    else begin
        state <= next_state;
        case (state)
            IDLE: begin
                shift_ena <= 0;
                counting <= 0;
                done <= 0;
            end
            DETECT_START: begin
                if (shift_count == 4'b1101) begin
                    next_state <= SHIFT_DURATION;
                    shift_count <= 0;
                end
                else begin
                    shift_count <= {shift_count[2:0], data};
                end
            end
            SHIFT_DURATION: begin
                shift_ena <= 1;
                if (shift_count == 4) begin
                    shift_ena <= 0;
                    next_state <= COUNT;
                end
                else begin
                    shift_count <= shift_count + 1;
                end
            end
            COUNT: begin
                counting <= 1;
                if (done_counting) begin
                    counting <= 0;
                    next_state <= NOTIFY;
                end
            end
            NOTIFY: begin
                done <= 1;
                if (ack) begin
                    next_state <= IDLE;
                end
            end
        endcase
    end
end

endmodule
