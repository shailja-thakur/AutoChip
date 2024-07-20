module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

localparam DETECT_START = 0, SHIFT_DELAY = 1, COUNT_DELAY = 2, WAIT_ACK = 3;
reg [1:0] state;
reg [3:0] delay;
reg [3:0] counter;

always @(posedge clk) begin
    if (reset) begin
        state <= DETECT_START;
        counting <= 0;
        done <= 0;
        delay <= 0;
        counter <= 0;
    end else begin
        case (state)
            DETECT_START: begin
                // Detect the start sequence 1101
                if (data == 1'b1 && {data, data, data, data} == 4'b1101) begin
                    state <= SHIFT_DELAY;
                end
            end
            SHIFT_DELAY: begin
                // Shift in the delay value
                delay <= {data, delay[3:1]};
                if (delay[0]) begin
                    state <= COUNT_DELAY;
                    counting <= 1;
                    counter <= 0;
                end
            end
            COUNT_DELAY: begin
                // Count down the delay
                counter <= counter + 1;
                if (counter == delay) begin
                    counting <= 0;
                    done <= 1;
                    state <= WAIT_ACK;
                end
            end
            WAIT_ACK: begin
                // Wait for the user to acknowledge
                if (ack) begin
                    state <= DETECT_START;
                    done <= 0;
                end
            end
        endcase
    end
end

assign count = delay - counter;

endmodule
