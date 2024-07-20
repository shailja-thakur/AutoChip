module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

localparam PATTERN = 4'b1101;
localparam STATE_SEARCH = 2'b00;
localparam STATE_SHIFT = 2'b01;
localparam STATE_COUNT = 2'b10;
localparam STATE_DONE = 2'b11;

reg [1:0] state;
reg [3:0] shift_reg;
reg [3:0] delay;
reg [13:0] counter;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= STATE_SEARCH;
        counting <= 0;
        done <= 0;
        shift_reg <= 0;
        delay <= 0;
        counter <= 0;
    end else begin
        case (state)
            STATE_SEARCH: begin
                // Shift in bits until the pattern 1101 is detected
                shift_reg <= {shift_reg[2:0], data};
                if (shift_reg == PATTERN) begin
                    state <= STATE_SHIFT;
                    shift_reg <= 0;
                end
            end
            STATE_SHIFT: begin
                // Shift in the 4-bit delay value
                shift_reg <= {shift_reg[2:0], data};
                if (shift_reg[3:0] == 4'b1111) begin
                    delay <= shift_reg[3:0];
                    state <= STATE_COUNT;
                    counter <= 0;
                    counting <= 1;
                end
            end
            STATE_COUNT: begin
                // Count down the timer
                counter <= counter + 1;
                if (counter == (delay + 1) * 1000 - 1) begin
                    counting <= 0;
                    done <= 1;
                    state <= STATE_DONE;
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

assign count = (state == STATE_COUNT) ? delay - (counter / 1000) : 4'bxxxx;

endmodule
