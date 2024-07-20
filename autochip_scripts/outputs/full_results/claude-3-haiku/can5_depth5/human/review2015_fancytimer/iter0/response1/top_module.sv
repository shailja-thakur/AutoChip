module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

parameter WAIT_START = 0, WAIT_DURATION = 1, COUNTING = 2, WAIT_ACK = 3;
reg [1:0] state;
reg [3:0] shift_reg;
reg [13:0] timer;
reg [3:0] delay;

always @(posedge clk) begin
    if (reset) begin
        state <= WAIT_START;
        counting <= 0;
        done <= 0;
        shift_reg <= 0;
        delay <= 0;
        timer <= 0;
    end else begin
        case (state)
            WAIT_START: begin
                // Shift in 4 bits to detect the start sequence
                shift_reg <= {shift_reg[2:0], data};
                if (shift_reg == 4'b1101) begin
                    state <= WAIT_DURATION;
                end
            end
            WAIT_DURATION: begin
                // Shift in the 4-bit delay value
                shift_reg <= {shift_reg[2:0], data};
                if (shift_reg[3:0] == 4'b1111) begin
                    delay <= shift_reg[3:0];
                    state <= COUNTING;
                    counting <= 1;
                    timer <= 0;
                end
            end
            COUNTING: begin
                // Count the timer and update the count output
                timer <= timer + 1;
                if (timer == (delay + 1) * 1000 - 1) begin
                    state <= WAIT_ACK;
                    counting <= 0;
                    done <= 1;
                end
                count <= delay - (timer / 1000);
            end
            WAIT_ACK: begin
                // Wait for the user to acknowledge the timer
                if (ack) begin
                    state <= WAIT_START;
                    done <= 0;
                end
            end
        endcase
    end
end

endmodule
