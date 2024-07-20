module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

reg [3:0] delay; // Stores the delay value
reg [3:0] counter; // Counts down the delay
reg [3:0] pattern; // Stores the pattern being detected
reg [1:0] state; // Keeps track of the current state

// States
parameter IDLE = 2'b00, // Waiting for the 1101 pattern
          DELAY = 2'b01, // Capturing the delay value
          COUNTING = 2'b10, // Counting down the delay
          DONE = 2'b11; // Timer has finished

// Counter
assign count = counter;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        pattern <= 4'b0;
        delay <= 4'b0;
        counter <= 4'b0;
        counting <= 1'b0;
        done <= 1'b0;
    end else begin
        case (state)
            IDLE: begin
                // Detect the 1101 pattern
                pattern <= {pattern[2:0], data};
                if (pattern == 4'b1101) begin
                    state <= DELAY;
                end
            end
            DELAY: begin
                // Capture the delay value
                delay <= {data, delay[3:1]};
                if (delay == 4'b0000) begin
                    state <= COUNTING;
                    counter <= delay + 1;
                    counting <= 1'b1;
                end
            end
            COUNTING: begin
                // Count down the delay
                counter <= counter - 1;
                if (counter == 4'b0000) begin
                    state <= DONE;
                    counting <= 1'b0;
                    done <= 1'b1;
                end
            end
            DONE: begin
                // Wait for acknowledgement
                if (ack) begin
                    state <= IDLE;
                    done <= 1'b0;
                end
            end
            default: begin
                state <= IDLE;
            end
        endcase
    end
end

endmodule
