module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    reg [3:0] delay;
    reg [3:0] current_count;
    reg [3:0] remaining_time;
    reg [3:0] next_state;
    reg [3:0] state;
    reg start_detected;
    reg [3:0] shift_count;
    reg [3:0] shift_data;

    parameter IDLE = 4'b0000;
    parameter DETECT_START = 4'b0001;
    parameter SHIFT_IN_DELAY = 4'b0010;
    parameter COUNT = 4'b0011;
    parameter WAIT_FOR_ACK = 4'b0100;
    parameter RESET = 4'b0101;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= RESET;
            counting <= 0;
            done <= 0;
            current_count <= 0;
            remaining_time <= 0;
            delay <= 0;
            start_detected <= 0;
            shift_count <= 0;
        end else begin
            case(state)
                IDLE: begin
                    if (data == 1'b1) begin
                        start_detected <= 1;
                        next_state <= DETECT_START;
                    end else begin
                        next_state <= IDLE;
                    end
                end

                DETECT_START: begin
                    if (start_detected) begin
                        if (shift_count == 4) begin
                            shift_data <= data;
                            next_state <= SHIFT_IN_DELAY;
                        end else begin
                            shift_count <= shift_count + 1;
                            next_state <= DETECT_START;
                        end
                    end else begin
                        if (data == 1'b1) begin
                            start_detected <= 1;
                        end else begin
                            start_detected <= 0;
                        end
                        next_state <= DETECT_START;
                    end
                end

                SHIFT_IN_DELAY: begin
                    delay <= shift_data;
                    next_state <= COUNT;
                end

                COUNT: begin
                    if (current_count == delay) begin
                        next_state <= WAIT_FOR_ACK;
                    end else begin
                        next_state <= COUNT;
                    end
                end

                WAIT_FOR_ACK: begin
                    if (ack == 1'b1) begin
                        next_state <= RESET;
                    end else begin
                        next_state <= WAIT_FOR_ACK;
                    end
                end

                RESET: begin
                    if (data == 1'b1) begin
                        start_detected <= 1;
                        next_state <= DETECT_START;
                    end else begin
                        start_detected <= 0;
                        next_state <= IDLE;
                    end
                end
            endcase
        end
    end

    always @(posedge clk) begin
        state <= next_state;
        if (state == COUNT) begin
            counting <= 1;
        end else begin
            counting <= 0;
        end

        if (state == RESET) begin
            done <= 1;
        end else begin
            done <= 0;
        end

        if (counting) begin
            current_count <= current_count + 1;
            if (current_count == delay) begin
                if (remaining_time == 0) begin
                    remaining_time <= delay - 1;
                end else begin
                    remaining_time <= remaining_time - 1;
                end
            end
        end else begin
            current_count <= 0;
            remaining_time <= delay;
        end
    end

    assign count = remaining_time;

endmodule
