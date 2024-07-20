module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

localparam IDLE = 2'b00, DETECT_PATTERN = 2'b01, COUNTDOWN = 2'b10, WAIT_ACK = 2'b11;
reg [1:0] state, next_state;
reg [3:0] pattern, delay;
reg [9:0] counter;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        pattern <= 4'b0;
        delay <= 4'b0;
        counter <= 10'b0;
        counting <= 1'b0;
        done <= 1'b0;
    end else begin
        state <= next_state;
        case (state)
            IDLE: begin
                if (data == 1'b1) pattern[3:0] <= {pattern[2:0], data};
                else pattern <= 4'b0;
                if (pattern == 4'b1101) next_state <= DETECT_PATTERN;
                else next_state <= IDLE;
            end
            DETECT_PATTERN: begin
                if (data == 1'b1) delay[3:0] <= {delay[2:0], data};
                else delay <= 4'b0;
                if (delay[3:0] == 4'b1111) next_state <= COUNTDOWN;
                else next_state <= DETECT_PATTERN;
            end
            COUNTDOWN: begin
                counter <= counter + 1;
                if (counter == (delay[3:0] + 1) * 10'd1000 - 1) begin
                    counter <= 10'b0;
                    next_state <= WAIT_ACK;
                    done <= 1'b1;
                    counting <= 1'b0;
                end else begin
                    next_state <= COUNTDOWN;
                    counting <= 1'b1;
                end
            end
            WAIT_ACK: begin
                if (ack) begin
                    next_state <= IDLE;
                    done <= 1'b0;
                end else begin
                    next_state <= WAIT_ACK;
                end
            end
        endcase
    end
end

assign count = (state == COUNTDOWN) ? delay[3:0] - (counter / 10'd1000) : 4'b0;

endmodule
