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

parameter IDLE = 0, DETECT = 1, SHIFT = 2, COUNT = 3, WAIT = 4;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        counting <= 0;
        done <= 0;
        pattern <= 0;
    end else begin
        case (state)
            IDLE: begin
                if (data == 1'b1) pattern <= {pattern[2:0], data};
                if (pattern == 4'b1101) begin
                    state <= DETECT;
                    pattern <= 0;
                end
            end
            DETECT: begin
                if (data == 1'b1) pattern <= {pattern[2:0], data};
                if (pattern == 4'b0000) begin
                    state <= SHIFT;
                    pattern <= 0;
                end
            end
            SHIFT: begin
                if (data == 1'b1) delay <= {delay[2:0], data};
                if (counter == 4'b0100) begin
                    state <= COUNT;
                    counter <= 0;
                    counting <= 1;
                end else begin
                    counter <= counter + 1;
                end
            end
            COUNT: begin
                if (counter == delay + 1) begin
                    state <= WAIT;
                    counting <= 0;
                    done <= 1;
                    counter <= 0;
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
        endcase
    end
end

assign count = (state == COUNT) ? delay - counter + 1 : 0;

endmodule
