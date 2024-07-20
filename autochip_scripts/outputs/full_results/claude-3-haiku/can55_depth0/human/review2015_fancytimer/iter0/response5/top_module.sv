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
parameter WAIT_START = 4'd0, CAPTURE_DELAY = 4'd1, COUNTING = 4'd2, WAIT_ACK = 4'd3;

always @(posedge clk) begin
    if (reset) begin
        state <= WAIT_START;
        counting <= 0;
        done <= 0;
    end else begin
        case (state)
            WAIT_START: begin
                // Search for the start sequence 1101
                if (data == 1'b1 && counter == 4'd0) counter <= 4'd1;
                else if (data == 1'b1 && counter == 4'd1) counter <= 4'd2;
                else if (data == 1'b0 && counter == 4'd2) counter <= 4'd3;
                else if (data == 1'b1 && counter == 4'd3) begin
                    // Start sequence detected, capture the delay value
                    state <= CAPTURE_DELAY;
                    counter <= 4'd0;
                end else counter <= 4'd0;
            end
            CAPTURE_DELAY: begin
                // Capture the 4-bit delay value
                delay[3] <= data;
                counter <= counter + 4'd1;
                if (counter == 4'd4) begin
                    // Delay value captured, start counting
                    state <= COUNTING;
                    counter <= 4'd0;
                    counting <= 1;
                end
            end
            COUNTING: begin
                // Count down the timer
                if (counter == delay) begin
                    // Timer finished, notify the user
                    counting <= 0;
                    done <= 1;
                    state <= WAIT_ACK;
                end else begin
                    counter <= counter + 4'd1;
                end
            end
            WAIT_ACK: begin
                // Wait for the user to acknowledge the timer
                if (ack) begin
                    // Timer acknowledged, reset to wait for the next start sequence
                    state <= WAIT_START;
                    done <= 0;
                end
            end
        endcase
    end
end

assign count = (state == COUNTING) ? delay - counter : 4'd0;

endmodule
