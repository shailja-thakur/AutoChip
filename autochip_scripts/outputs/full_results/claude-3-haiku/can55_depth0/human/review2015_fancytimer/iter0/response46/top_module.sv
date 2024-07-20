module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

reg [3:0] state, next_state;
reg [3:0] pattern;
reg [3:0] delay;
reg [19:0] counter;

// State machine
localparam [3:0] IDLE = 4'b0000,
                 DETECT_PATTERN = 4'b0001,
                 READ_DELAY = 4'b0010,
                 COUNTING = 4'b0011,
                 NOTIFY = 4'b0100;

// Detect pattern
always @(posedge clk) begin
    if (reset) begin
        pattern <= 4'b1101;
        state <= IDLE;
    end else begin
        case (state)
            IDLE: begin
                if (data == pattern[3]) begin
                    pattern <= {pattern[2:0], data};
                    if (pattern == 4'b1101) begin
                        state <= DETECT_PATTERN;
                    end
                end else begin
                    pattern <= 4'b1101;
                end
            end
            DETECT_PATTERN: begin
                pattern <= {pattern[2:0], data};
                if (pattern == 4'b0000) begin
                    state <= READ_DELAY;
                end
            end
            READ_DELAY: begin
                delay <= {delay[2:0], data};
                if (delay == 4'b1111) begin
                    state <= COUNTING;
                    counter <= 0;
                    counting <= 1;
                end
            end
            COUNTING: begin
                counter <= counter + 1;
                if (counter == (delay + 1) * 1000 - 1) begin
                    state <= NOTIFY;
                    counting <= 0;
                    done <= 1;
                end
            end
            NOTIFY: begin
                if (ack) begin
                    state <= IDLE;
                    done <= 0;
                end
            end
        endcase
    end
end

assign count = (state == COUNTING) ? delay - (counter / 1000) : 4'hx;

endmodule
