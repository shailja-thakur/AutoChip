module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack );
    
    reg [3:0] state;
    reg [3:0] next_state;

    parameter IDLE = 0;
    parameter DETECT = 1;
    parameter SHIFT = 2;
    parameter WAIT_COUNTING = 3;
    parameter NOTIFY = 4;
    parameter WAIT_ACK = 5;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
        end
        else begin
            state <= next_state;
        end
    end

    always @* begin
        case (state)
            IDLE: begin
                shift_ena <= 0;
                counting <= 0;
                done <= 0;
                if (data == 4'b1101) begin
                    next_state = DETECT;
                end
                else begin
                    next_state = IDLE;
                end
            end

            DETECT: begin
                shift_ena <= 1;
                counting <= 0;
                done <= 0;
                next_state = SHIFT;
            end

            SHIFT: begin
                shift_ena <= 1;
                counting <= 0;
                done <= 0;
                if (done_counting == 1) begin
                    next_state = NOTIFY;
                end
                else begin
                    next_state = SHIFT;
                end
            end

            WAIT_COUNTING: begin
                shift_ena <= 0;
                counting <= 1;
                done <= 0;
                if (done_counting == 1) begin
                    next_state = NOTIFY;
                end
                else begin
                    next_state = WAIT_COUNTING;
                end
            end

            NOTIFY: begin
                shift_ena <= 0;
                counting <= 0;
                done <= 1;
                next_state = WAIT_ACK;
            end

            WAIT_ACK: begin
                shift_ena <= 0;
                counting <= 0;
                done <= 1;
                if (ack == 1) begin
                    next_state = IDLE;
                end
                else begin
                    next_state = WAIT_ACK;
                end
            end
        endcase
    end
endmodule
