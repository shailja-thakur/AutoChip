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
reg [3:0] pattern;
reg [1:0] state;

parameter IDLE = 2'b00;
parameter DETECT = 2'b01;
parameter COUNT = 2'b10;
parameter WAIT = 2'b11;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        counting <= 0;
        done <= 0;
        pattern <= 0;
        delay <= 0;
        counter <= 0;
    end else begin
        case (state)
            IDLE: begin
                if (pattern == 4'b1101) begin
                    state <= DETECT;
                    pattern <= 0;
                end else begin
                    pattern <= {pattern[2:0], data};
                end
            end
            DETECT: begin
                if (counter == 4'b1111) begin
                    delay <= {pattern};
                    counter <= 0;
                    state <= COUNT;
                    counting <= 1;
                end else begin
                    pattern <= {pattern[2:0], data};
                    counter <= counter + 1;
                end
            end
            COUNT: begin
                if (counter == delay) begin
                    counting <= 0;
                    done <= 1;
                    state <= WAIT;
                end else begin
                    counter <= counter + 1;
                end
            end
            WAIT: begin
                if (ack) begin
                    state <= IDLE;
                    done <= 0;
                end
            end
            default: begin
                state <= IDLE;
            end
        endcase
    end
end

assign count = (state == COUNT) ? delay - counter : 4'bxxxx;

endmodule
