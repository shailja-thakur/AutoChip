module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

localparam STATE_SEARCH = 0;
localparam STATE_LOAD_DELAY = 1;
localparam STATE_COUNTDOWN = 2;
localparam STATE_DONE = 3;

reg [1:0] state;
reg [3:0] delay;
reg [13:0] counter;

always @(posedge clk) begin
    if (reset) begin
        state <= STATE_SEARCH;
        counting <= 0;
        done <= 0;
        counter <= 0;
    end
    else begin
        case (state)
            STATE_SEARCH: begin
                // Search for the start sequence 1101
                if (data == 1'b1) begin
                    if ({data, data, data, data} == 4'b1101) begin
                        state <= STATE_LOAD_DELAY;
                        counter <= 0;
                    end
                end
                else begin
                    counting <= 0;
                    done <= 0;
                end
            end
            STATE_LOAD_DELAY: begin
                // Shift in the 4-bit delay value
                delay <= {data, delay[3:1]};
                counter <= counter + 1;
                if (counter == 4) begin
                    state <= STATE_COUNTDOWN;
                    counting <= 1;
                    counter <= 0;
                end
            end
            STATE_COUNTDOWN: begin
                // Count down the timer
                counter <= counter + 1;
                if (counter == (delay + 1) * 1000 - 1) begin
                    state <= STATE_DONE;
                    counting <= 0;
                    done <= 1;
                    counter <= 0;
                end
            end
            STATE_DONE: begin
                // Wait for user acknowledgement
                if (ack) begin
                    state <= STATE_SEARCH;
                    done <= 0;
                end
            end
        endcase
    end
end

assign count = delay - (counter / 1000);

endmodule
