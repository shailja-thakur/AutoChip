module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

localparam STATE_WAIT_START = 0;
localparam STATE_SHIFT_DELAY = 1;
localparam STATE_COUNTING = 2;
localparam STATE_DONE = 3;

reg [1:0] state;
reg [3:0] shift_reg;
reg [15:0] timer;
reg [3:0] delay;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= STATE_WAIT_START;
        shift_reg <= 0;
        timer <= 0;
        delay <= 0;
        counting <= 0;
        done <= 0;
    end else begin
        case (state)
            STATE_WAIT_START: begin
                // Look for 1101 start pattern
                shift_reg <= {shift_reg[2:0], data};
                if (shift_reg == 4'b1101) begin
                    state <= STATE_SHIFT_DELAY;
                end
            end
            STATE_SHIFT_DELAY: begin
                // Shift in 4-bit delay value
                shift_reg <= {shift_reg[2:0], data};
                if (shift_reg[3:0] == 4'b1111) begin
                    delay <= shift_reg[3:0];
                    state <= STATE_COUNTING;
                    counting <= 1;
                    timer <= 0;
                end
            end
            STATE_COUNTING: begin
                // Count down the timer
                timer <= timer + 1;
                if (timer >= (delay + 1) * 1000 - 1) begin
                    state <= STATE_DONE;
                    counting <= 0;
                    done <= 1;
                end
            end
            STATE_DONE: begin
                // Wait for user acknowledgement
                if (ack) begin
                    state <= STATE_WAIT_START;
                    done <= 0;
                end
            end
        endcase
    end
end

assign count = delay - (timer / 1000);

endmodule
