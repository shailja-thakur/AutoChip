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
    reg [1:0] state, next_state;

    localparam IDLE = 2'd0,
               READ_DELAY = 2'd1,
               COUNT = 2'd2,
               WAIT_ACK = 2'd3;

    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            bit_count <= 0;
            counting <= 0;
            done <= 0;
        end else begin
            state <= next_state;
            if (state == IDLE || state == READ_DELAY) begin
                if (state == IDLE && data == 1'b1) begin
                    bit_count <= (bit_count << 1) | data;
                end else if (state == READ_DELAY) begin
                    bit_count <= bit_count + 1;
                    if (bit_count < 4) begin
                        delay <= {delay[2:0], data};
                    end
                end
            end else if (state == COUNT) begin
                if (countdown > 0) begin
                    if (cycle_count == 10'd999) begin
                        countdown <= countdown - 1;
                        cycle_count <= 0;
                    end else begin
                        cycle_count <= cycle_count + 1;
                    end
                end
            end else if (state == WAIT_ACK) begin
                if (ack) begin
                    done <= 0;
                    counting <= 0;
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
                end
            end

            COUNT: begin
                if (cycle_count == 10'd999) begin
                    if (countdown == 0) begin
                        next_state = WAIT_ACK;
                        done = 1;
                    end
                end
            end

            WAIT_ACK: begin
                if (ack) begin
                    next_state = IDLE;
                end
            end
        endcase
    end

    assign count = (counting) ? countdown : 4'bxxxx;

endmodule
