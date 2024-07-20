module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

// State machine states
localparam [2:0] IDLE = 3'd0,
                 DETECT_PATTERN = 3'd1,
                 READ_DELAY = 3'd2,
                 DELAY_COUNTDOWN = 3'd3,
                 NOTIFY_USER = 3'd4;

reg [2:0] state;
reg [3:0] pattern;
reg [3:0] delay;
reg [9:0] counter;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
        pattern <= 4'b0;
        delay <= 4'b0;
        counter <= 10'b0;
        counting <= 1'b0;
        done <= 1'b0;
    end else begin
        case (state)
            IDLE: begin
                if (data == 1'b1) begin
                    pattern <= {pattern[2:0], data};
                    if (pattern == 4'b1101) begin
                        state <= DETECT_PATTERN;
                    end
                end else begin
                    pattern <= {pattern[2:0], data};
                end
            end
            DETECT_PATTERN: begin
                if (data == 1'b1) begin
                    pattern <= {pattern[2:0], data};
                    if (pattern == 4'b0000) begin
                        state <= READ_DELAY;
                    end
                end else begin
                    pattern <= {pattern[2:0], data};
                end
            end
            READ_DELAY: begin
                delay <= {data, delay[3:1]};
                if (delay[0] == 1'b1) begin
                    state <= DELAY_COUNTDOWN;
                    counting <= 1'b1;
                    counter <= 10'd0;
                end
            end
            DELAY_COUNTDOWN: begin
                counter <= counter + 1;
                if (counter == (delay + 1) * 10'd1000 - 1) begin
                    state <= NOTIFY_USER;
                    counting <= 1'b0;
                    done <= 1'b1;
                end
            end
            NOTIFY_USER: begin
                if (ack == 1'b1) begin
                    state <= IDLE;
                    done <= 1'b0;
                end
            end
            default: state <= IDLE;
        endcase
    end
end

assign count = delay - (counter / 1000);

endmodule
