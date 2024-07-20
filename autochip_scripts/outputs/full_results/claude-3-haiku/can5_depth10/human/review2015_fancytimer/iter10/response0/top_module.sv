module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

reg [3:0] delay;
reg [31:0] counter;
reg [3:0] state;
reg [3:0] shift_reg;

parameter WAIT_START = 4'b0000;
parameter SHIFT_DELAY = 4'b0001;
parameter COUNT = 4'b0010;
parameter DONE = 4'b0011;

always @(posedge clk) begin
    if (reset) begin
        state <= WAIT_START;
        counting <= 0;
        done <= 0;
        shift_reg <= 0;
        counter <= 0;
        delay <= 0;
        count <= 0;
    end
    else begin
        case (state)
            WAIT_START: begin
                // Look for the start sequence 1101
                shift_reg <= {shift_reg[2:0], data};
                if (shift_reg == 4'b1101) begin
                    state <= SHIFT_DELAY;
                    counter <= 0;
                end
            end
            SHIFT_DELAY: begin
                // Shift in the delay value
                shift_reg <= {shift_reg[2:0], data};
                counter <= counter + 1;
                if (counter == 4) begin
                    delay <= shift_reg;
                    state <= COUNT;
                    counting <= 1;
                    counter <= 0;
                end
            end
            COUNT: begin
                // Count down the timer
                counter <= counter + 1;
                count <= delay - (counter / 1000);
                if (counter == (delay + 1) * 1000 - 1) begin
                    counter <= 0;
                    if (delay == 0) begin
                        state <= DONE;
                        counting <= 0;
                        done <= 1;
                    end
                    else begin
                        delay <= delay - 1;
                    end
                end
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
