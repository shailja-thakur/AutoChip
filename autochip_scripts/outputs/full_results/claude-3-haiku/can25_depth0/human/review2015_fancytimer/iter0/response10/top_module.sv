module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

// States
parameter IDLE = 2'b00;
parameter DETECT_PATTERN = 2'b01;
parameter LOAD_DELAY = 2'b10;
parameter COUNTDOWN = 2'b11;

// Registers
reg [1:0] state;
reg [3:0] pattern;
reg [3:0] delay;
reg [12:0] counter;

// State machine
always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
        pattern <= 4'b0;
        delay <= 4'b0;
        counter <= 13'b0;
        counting <= 1'b0;
        done <= 1'b0;
    end else begin
        case (state)
            IDLE: begin
                if (pattern == 4'b1101) begin
                    state <= LOAD_DELAY;
                    pattern <= 4'b0;
                end else begin
                    pattern <= {pattern[2:0], data};
                end
                counting <= 1'b0;
                done <= 1'b0;
            end
            LOAD_DELAY: begin
                if (counter < 4) begin
                    delay[3-counter] <= data;
                    counter <= counter + 1;
                end else begin
                    state <= COUNTDOWN;
                    counter <= 13'b0;
                    counting <= 1'b1;
                end
            end
            COUNTDOWN: begin
                if (counter < (delay + 1) * 1000 - 1) begin
                    counter <= counter + 1;
                end else begin
                    state <= IDLE;
                    counting <= 1'b0;
                    done <= 1'b1;
                end
            end
            default: begin
                state <= IDLE;
            end
        endcase
    end
end

// Output
assign count = (state == COUNTDOWN) ? delay - (counter / 1000) : 4'bxxxx;

endmodule
