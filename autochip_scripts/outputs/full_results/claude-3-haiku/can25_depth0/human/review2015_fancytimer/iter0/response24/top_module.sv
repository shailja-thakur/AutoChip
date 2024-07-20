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
reg [3:0] shift_reg;

localparam WAIT_START = 0, SHIFT_DELAY = 1, COUNT_TIMER = 2, WAIT_ACK = 3;

always @(posedge clk) begin
    if (reset) begin
        state <= WAIT_START;
        counting <= 0;
        done <= 0;
        shift_reg <= 0;
    end
    else begin
        case (state)
            WAIT_START: begin
                // Look for start pattern 1101
                shift_reg <= {shift_reg[2:0], data};
                if (shift_reg == 4'b1101) begin
                    state <= SHIFT_DELAY;
                    shift_reg <= 0;
                end
            end
            SHIFT_DELAY: begin
                // Shift in delay value
                shift_reg <= {shift_reg[2:0], data};
                if (shift_reg[3]) begin
                    delay <= shift_reg;
                    counter <= 0;
                    state <= COUNT_TIMER;
                    counting <= 1;
                end
            end
            COUNT_TIMER: begin
                // Count down timer
                counter <= counter + 1;
                if (counter == delay) begin
                    counting <= 0;
                    done <= 1;
                    state <= WAIT_ACK;
                end
            end
            WAIT_ACK: begin
                // Wait for user acknowledgement
                if (ack) begin
                    done <= 0;
                    state <= WAIT_START;
                end
            end
        endcase
    end
end

assign count = (state == COUNT_TIMER) ? delay - counter : 0;

endmodule
