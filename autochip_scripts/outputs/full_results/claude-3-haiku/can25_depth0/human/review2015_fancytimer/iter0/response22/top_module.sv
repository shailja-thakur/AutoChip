module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

localparam IDLE = 3'b000, DETECT = 3'b001, SHIFT = 3'b010, COUNTER = 3'b011, FINISHED = 3'b100;
reg [2:0] state;
reg [3:0] pattern;
reg [3:0] delay;
reg [9:0] counter;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        pattern <= 0;
        delay <= 0;
        counter <= 0;
        counting <= 0;
        done <= 0;
    end else begin
        case (state)
            IDLE: begin
                if (data == 1'b1) pattern <= {pattern[2:0], data};
                if (pattern == 4'b1101) state <= DETECT;
            end
            DETECT: begin
                if (data == 1'b1) pattern <= {pattern[2:0], data};
                if (pattern == 4'b0000) state <= SHIFT;
            end
            SHIFT: begin
                if (data == 1'b1) delay <= {delay[2:0], data};
                if (counter == 4'b0100) state <= COUNTER;
                counter <= counter + 1;
            end
            COUNTER: begin
                if (counter == (delay + 1) * 10'd1000) begin
                    state <= FINISHED;
                    counting <= 0;
                    done <= 1;
                end else begin
                    counting <= 1;
                    counter <= counter + 1;
                end
                assign count = (delay + 1) - (counter / 1000);
            end
            FINISHED: begin
                if (ack) begin
                    state <= IDLE;
                    pattern <= 0;
                    delay <= 0;
                    counter <= 0;
                    done <= 0;
                end
            end
            default: state <= IDLE;
        endcase
    end
end

endmodule
