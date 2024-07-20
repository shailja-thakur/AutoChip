module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

reg [3:0] delay;
reg [3:0] counter;
reg [3:0] state;
reg [3:0] pattern;

localparam IDLE = 4'd0;
localparam DETECT_PATTERN = 4'd1;
localparam READ_DELAY = 4'd2;
localparam COUNT = 4'd3;
localparam NOTIFY_USER = 4'd4;
localparam WAIT_ACK = 4'd5;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        counting <= 1'b0;
        done <= 1'b0;
        pattern <= 4'b0;
        delay <= 4'b0;
        counter <= 4'b0;
    end
    else begin
        case (state)
            IDLE: begin
                if (data == 1'b1) pattern[3:0] <= {pattern[2:0], data};
                else pattern[3:0] <= {pattern[2:0], data};

                if (pattern == 4'b1101) state <= DETECT_PATTERN;
                else state <= IDLE;
            end

            DETECT_PATTERN: begin
                if (data == 1'b1) delay[3:0] <= {delay[2:0], data};
                else delay[3:0] <= {delay[2:0], data};

                if (delay[3:0] == 4'b1111) state <= COUNT;
                else state <= READ_DELAY;
            end

            READ_DELAY: begin
                if (data == 1'b1) delay[3:0] <= {delay[2:0], data};
                else delay[3:0] <= {delay[2:0], data};

                if (delay[3:0] == 4'b1111) state <= COUNT;
                else state <= READ_DELAY;
            end

            COUNT: begin
                counting <= 1'b1;
                if (counter == delay + 1) begin
                    counter <= 4'b0;
                    counting <= 1'b0;
                    state <= NOTIFY_USER;
                end
                else begin
                    counter <= counter + 1;
                end
            end

            NOTIFY_USER: begin
                done <= 1'b1;
                state <= WAIT_ACK;
            end

            WAIT_ACK: begin
                if (ack) begin
                    done <= 1'b0;
                    state <= IDLE;
                end
                else begin
                    state <= WAIT_ACK;
                end
            end

            default: state <= IDLE;
        endcase
    end
end

assign count = counting ? delay - counter + 1 : 4'bxxxx;

endmodule
