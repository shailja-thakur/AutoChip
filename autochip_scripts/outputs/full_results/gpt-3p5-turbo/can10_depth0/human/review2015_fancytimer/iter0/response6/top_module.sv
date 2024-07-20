module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    reg [3:0] delay;
    reg [3:0] remainder;
    reg [3:0] counter;
    reg [3:0] state;

    // state definitions
    localparam IDLE = 4'b0000;
    localparam DETECT_PATTERN = 4'b0001;
    localparam SHIFT_IN_DELAY = 4'b0010;
    localparam COUNT = 4'b0011;
    localparam UPDATE_REMAINDER = 4'b0100;
    localparam CHECK_ACK = 4'b0101;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            delay <= 4'b0000;
            remainder <= 4'b0000;
            counter <= 4'b0000;
            state <= IDLE;
            counting <= 0;
            done <= 0;
        end else begin
            case(state)
                IDLE:
                    if (data[3:0] == 4'b1101) begin
                        state <= DETECT_PATTERN;
                    end
                DETECT_PATTERN:
                    state <= SHIFT_IN_DELAY;
                SHIFT_IN_DELAY:
                    delay <= data[3:0];
                    state <= COUNT;
                COUNT:
                    if (counter == (delay + 1)) begin
                        state <= UPDATE_REMAINDER;
                    end
                UPDATE_REMAINDER:
                    remainder <= delay - ((counter == 0) ? 1 : counter);
                    state <= CHECK_ACK;
                CHECK_ACK:
                    if (ack) begin
                        state <= IDLE;
                    end
            endcase
        end
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            counter <= 4'b0000;
        end else begin
            if (state == COUNT) begin
                counter <= counter + 1;
            end else begin
                counter <= 4'b0000;
            end
        end
    end

    always @(posedge clk) begin
        if (state == COUNT) begin
            counting <= 1;
        end else begin
            counting <= 0;
        end
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            done <= 0;
        end else begin
            if (remainder == 0 && state == UPDATE_REMAINDER) begin
                done <= 1;
            end else begin
                done <= 0;
            end
        end
    end

    assign count = remainder;
     
endmodule
