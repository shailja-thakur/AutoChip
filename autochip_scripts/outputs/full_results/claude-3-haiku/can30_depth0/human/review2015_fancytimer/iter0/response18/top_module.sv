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

localparam FIND_PATTERN = 2'b00;
localparam READ_DELAY = 2'b01;
localparam COUNTING = 2'b10;
localparam WAIT_ACK = 2'b11;

always @(posedge clk) begin
    if (reset) begin
        state <= FIND_PATTERN;
        pattern <= 4'b0;
        delay <= 4'b0;
        counter <= 4'b0;
        counting <= 1'b0;
        done <= 1'b0;
    end else begin
        case (state)
            FIND_PATTERN: begin
                // Shift in the pattern bits
                pattern <= {pattern[2:0], data};
                // Check for the 1101 pattern
                if (pattern == 4'b1101) begin
                    state <= READ_DELAY;
                end
            end
            READ_DELAY: begin
                // Shift in the delay bits
                delay <= {delay[2:0], data};
                // After 4 bits, start counting
                if (delay[3:0] == 4'b1111) begin
                    state <= COUNTING;
                    counter <= delay;
                    counting <= 1'b1;
                end
            end
            COUNTING: begin
                // Decrement the counter
                counter <= counter - 1;
                // If the counter reaches 0, finish counting
                if (counter == 4'b0000) begin
                    state <= WAIT_ACK;
                    counting <= 1'b0;
                    done <= 1'b1;
                end
            end
            WAIT_ACK: begin
                // Wait for the user to acknowledge the timer
                if (ack) begin
                    state <= FIND_PATTERN;
                    done <= 1'b0;
                end
            end
        endcase
    end
end

assign count = counter;

endmodule
