module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    reg [3:0] bit_count;
    reg [3:0] delay;
    reg [3:0] countdown;
    reg [9:0] cycle_count;
    reg [2:0] state, next_state;

    localparam IDLE = 3'd0,
               READ_DELAY = 3'd1,
               COUNT = 3'd2,
               WAIT_ACK = 3'd3,
               FINISHED = 3'd4;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            bit_count <= 0;
            counting <= 0;
            done <= 0;
        end else begin
            state <= next_state;
            if (state == IDLE) begin
                bit_count <= {bit_count[2:0], data};
            end else if (state == READ_DELAY) begin
                bit_count <= bit_count + 1;
                if (bit_count < 4) begin
                    delay <= {delay[2:0], data};
                end
            end else if (state == COUNT) begin
                if (cycle_count == 10'd999) begin
                    cycle_count <= 0;
                    if (countdown > 0) begin
                        countdown <= countdown - 1;
                    end else begin
                        next_state = FINISHED;
                    end
                end else begin
                    cycle_count <= cycle_count + 1;
                end
            end
        end
    end

    always @(*) begin
        next_state = state;
        case (state)
            IDLE: begin
                if (bit_count == 4'b1101) begin
                    next_state = READ_DELAY;
                    bit_count = 0;
                    delay = 0;
                end
            end

            READ_DELAY: begin
                if (bit_count == 4) begin
                    next_state = COUNT;
                    cycle_count = 0;
                    countdown = delay;
                    counting = 1;
                    bit_count = 0;
                end
            end

            COUNT: begin
                if (cycle_count == 10'd999 && countdown == 0) begin
                    next_state = FINISHED;
                end
            end

            FINISHED: begin
                counting = 0;
                done = 1;
                if (ack) begin
                    next_state = IDLE;
                    done = 0;
                end
            end

            default: next_state = IDLE;
        endcase
    end

    assign count = (counting) ? countdown : 4'bxxxx;

endmodule
