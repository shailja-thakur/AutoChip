module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

localparam STATE_WAIT_START = 0,
           STATE_CAPTURE_DURATION = 1,
           STATE_COUNTING = 2,
           STATE_WAIT_ACK = 3;

reg [1:0] state;
reg [3:0] duration;
reg [15:0] counter;

always @(posedge clk) begin
    if (reset) begin
        state <= STATE_WAIT_START;
        counting <= 0;
        done <= 0;
        counter <= 0;
        duration <= 0;
    end else begin
        case (state)
            STATE_WAIT_START: begin
                // Wait for the 1101 start pattern
                if (data == 1'b1 && counter[15:12] == 4'b1101) begin
                    counter <= 0;
                    state <= STATE_CAPTURE_DURATION;
                end else begin
                    counter <= {counter[14:0], data};
                end
            end
            STATE_CAPTURE_DURATION: begin
                // Capture the 4-bit duration
                if (counter < 4) begin
                    duration[counter] <= data;
                    counter <= counter + 1;
                end else begin
                    state <= STATE_COUNTING;
                    counting <= 1;
                    counter <= 0;
                end
            end
            STATE_COUNTING: begin
                // Count down the timer
                if (counter < (duration + 1) * 1000 - 1) begin
                    counter <= counter + 1;
                end else begin
                    counting <= 0;
                    done <= 1;
                    state <= STATE_WAIT_ACK;
                    counter <= 0;
                end
            end
            STATE_WAIT_ACK: begin
                // Wait for the user to acknowledge
                if (ack) begin
                    done <= 0;
                    state <= STATE_WAIT_START;
                end
            end
        endcase
    end
end

assign count = (state == STATE_COUNTING) ? (duration + 1 - counter / 1000) : 'bz;

endmodule
