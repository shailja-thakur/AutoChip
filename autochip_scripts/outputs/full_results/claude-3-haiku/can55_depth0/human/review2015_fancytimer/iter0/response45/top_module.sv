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

localparam WAIT_START = 0;
localparam WAIT_DELAY = 1;
localparam COUNTING = 2;
localparam DONE = 3;

always @(posedge clk) begin
    if (reset) begin
        state <= WAIT_START;
        counting <= 0;
        done <= 0;
    end else begin
        case (state)
            WAIT_START: begin
                // Look for the starting pattern 1101
                if (data == 1'b1 && {data, data, data, data} == 4'b1101) begin
                    state <= WAIT_DELAY;
                    counter <= 0;
                end
            end
            WAIT_DELAY: begin
                // Shift in the 4-bit delay value
                delay <= {data, delay[3:1]};
                counter <= counter + 1;
                if (counter == 4) begin
                    state <= COUNTING;
                    counter <= 0;
                    counting <= 1;
                end
            end
            COUNTING: begin
                // Count down the timer
                counter <= counter + 1;
                if (counter == delay) begin
                    counter <= 0;
                    delay <= delay - 1;
                end
                if (delay == 0) begin
                    state <= DONE;
                    counting <= 0;
                    done <= 1;
                end
            end
            DONE: begin
                // Wait for the user to acknowledge the timer
                if (ack) begin
                    state <= WAIT_START;
                    done <= 0;
                end
            end
        endcase
    end
end

assign count = delay;

endmodule
