module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

localparam WAIT_START = 2'b00;
localparam WAIT_DELAY = 2'b01;
localparam COUNTING = 2'b10;
localparam DONE = 2'b11;

reg [1:0] state;
reg [3:0] delay;
reg [9:0] counter;

always @(posedge clk) begin
    if (reset) begin
        state <= WAIT_START;
        counting <= 0;
        done <= 0;
        delay <= 0;
        counter <= 0;
    end else begin
        case (state)
            WAIT_START: begin
                // Shift in the 1101 start pattern
                if (data == 1'b1 && {data, data, data, data} == 4'b1101) begin
                    state <= WAIT_DELAY;
                end
            end
            WAIT_DELAY: begin
                // Shift in the 4-bit delay value
                delay <= {data, delay[3:1]};
                if (delay[0]) begin
                    state <= COUNTING;
                    counting <= 1;
                    counter <= 0;
                end
            end
            COUNTING: begin
                // Count down the timer
                counter <= counter + 1;
                if (counter == (delay + 1) * 1000 - 1) begin
                    state <= DONE;
                    counting <= 0;
                    done <= 1;
                end
                count <= delay - (counter / 1000);
            end
            DONE: begin
                // Wait for acknowledgement
                if (ack) begin
                    state <= WAIT_START;
                    done <= 0;
                end
            end
        endcase
    end
end

endmodule
