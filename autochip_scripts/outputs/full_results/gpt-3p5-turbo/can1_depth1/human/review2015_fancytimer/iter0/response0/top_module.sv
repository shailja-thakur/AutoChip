module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

reg [3:0] delay;
reg [2:0] state;

// State definitions
parameter IDLE = 0;
parameter DETECT_START = 1;
parameter SHIFT_IN_DELAY = 2;
parameter COUNT = 3;
parameter DONE = 4;

// Default assignments
assign counting = (state == COUNT);
assign count = (counting) ? delay : 4'bX;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        delay <= 0;
        done <= 0;
    end else begin
        case(state)
            IDLE: begin
                if (data == 4'b1101) begin
                    state <= DETECT_START;
                end else begin
                    state <= IDLE;
                end
            end
            DETECT_START: begin
                state <= SHIFT_IN_DELAY;
            end
            SHIFT_IN_DELAY: begin
                delay <= data;
                state <= COUNT;
            end
            COUNT: begin
                if (count == 0) begin
                    state <= DONE;
                    done <= 1;
                end else begin
                    state <= COUNT;
                    delay <= delay - 1;
                end
            end
            DONE: begin
                if (ack == 1) begin
                    state <= IDLE;
                    done <= 0;
                end else begin
                    state <= DONE;
                end
            end
        endcase
    end
end

endmodule
