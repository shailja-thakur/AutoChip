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
reg [3:0] timer_count;
reg [3:0] pattern;
reg [1:0] state;

localparam IDLE = 2'b00;
localparam START = 2'b01;
localparam COUNT = 2'b10;
localparam DONE = 2'b11;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        counting <= 0;
        done <= 0;
        pattern <= 0;
    end
    else begin
        case (state)
            IDLE: begin
                // Look for the start sequence (1101)
                pattern <= {pattern[2:0], data};
                if (pattern == 4'b1101) begin
                    state <= START;
                    counting <= 0;
                    done <= 0;
                end
            end
            START: begin
                // Shift in the delay value
                delay <= {delay[2:0], data};
                if (delay[3]) begin
                    state <= COUNT;
                    timer_count <= delay;
                    counting <= 1;
                end
            end
            COUNT: begin
                // Decrement the timer and output the remaining time
                if (timer_count > 0) begin
                    timer_count <= timer_count - 1;
                end
                else begin
                    state <= DONE;
                    counting <= 0;
                    done <= 1;
                end
            end
            DONE: begin
                // Wait for acknowledgement
                if (ack) begin
                    state <= IDLE;
                    done <= 0;
                end
            end
        endcase
    end
end

assign count = (state == COUNT) ? timer_count : 4'bxxxx;

endmodule
