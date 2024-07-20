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

localparam [1:0] IDLE = 2'b00, 
                 DETECT = 2'b01,
                 COUNT = 2'b10,
                 NOTIFY = 2'b11;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        counting <= 0;
        done <= 0;
        pattern <= 0;
        counter <= 0;
        delay <= 0;
    end else begin
        case (state)
            IDLE: begin
                // Search for the start pattern 1101
                pattern <= {pattern[2:0], data};
                if (pattern == 4'b1101) begin
                    state <= DETECT;
                end
            end
            DETECT: begin
                // Shift in the 4-bit delay value
                delay <= {delay[2:0], data};
                if (delay[3]) begin
                    state <= COUNT;
                    counting <= 1;
                    counter <= 0;
                end
            end
            COUNT: begin
                // Count down the timer
                counter <= counter + 1;
                if (counter == (delay + 1) * 250 - 1) begin
                    counting <= 0;
                    state <= NOTIFY;
                    done <= 1;
                end
            end
            NOTIFY: begin
                // Wait for the user to acknowledge the timer
                if (ack) begin
                    state <= IDLE;
                    done <= 0;
                end
            end
        endcase
    end
end

assign count = counting ? (delay + 1 - counter / 250) : 4'bxxxx;

endmodule
