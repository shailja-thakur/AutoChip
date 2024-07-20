module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack );

    reg [2:0] state;
    reg [2:0] next_state;
    reg [3:0] count;

    parameter IDLE = 0;
    parameter DETECT = 1;
    parameter SHIFT = 2;
    parameter COUNT = 3;
    parameter NOTIFY = 4;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            count <= 0;
            shift_ena <= 0;
            counting <= 0;
            done <= 0;
        end else begin
            state <= next_state;
        end
    end

    always @* begin
        next_state = state;

        case(state)
            IDLE: begin
                if (data == 4'b1101) begin
                    next_state = DETECT;
                    count <= 0;
                end
            end

            DETECT: begin
                if (data == 4'b1101) begin
                    next_state = SHIFT;
                end else begin
                    next_state = IDLE;
                end
            end

            SHIFT: begin
                if (count < 3) begin
                    count <= count + 1;
                    shift_ena <= 1;
                    counting <= 0;
                    done <= 0;
                end else begin
                    next_state = COUNT;
                    shift_ena <= 0;
                end
            end

            COUNT: begin
                if (done_counting) begin
                    next_state = NOTIFY;
                    count <= 0;
                end
            end

            NOTIFY: begin
                if (ack) begin
                    next_state = IDLE;
                    done <= 1;
                end
            end

        endcase
    end

endmodule
