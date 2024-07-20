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

localparam WAIT_START = 4'b0000;
localparam SHIFT_DELAY = 4'b0001;
localparam COUNT_DOWN = 4'b0010;
localparam WAIT_ACK = 4'b0011;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= WAIT_START;
        counting <= 0;
        done <= 0;
        shift_reg <= 0;
        delay <= 0;
        counter <= 0;
    end else begin
        case (state)
            WAIT_START: begin
                // Wait for the 1101 start pattern
                if (shift_reg[3:0] == 4'b1101) begin
                    state <= SHIFT_DELAY;
                    shift_reg <= 0;
                end else begin
                    shift_reg <= {shift_reg[2:0], data};
                end
            end
            SHIFT_DELAY: begin
                // Shift in the 4-bit delay value
                shift_reg <= {shift_reg[2:0], data};
                if (shift_reg[3:0] == 4'b0000) begin
                    delay <= shift_reg[7:4];
                    counter <= delay + 1;
                    state <= COUNT_DOWN;
                    counting <= 1;
                end
            end
            COUNT_DOWN: begin
                // Count down the timer
                counter <= counter - 1;
                if (counter == 0) begin
                    state <= WAIT_ACK;
                    counting <= 0;
                    done <= 1;
                end
            end
            WAIT_ACK: begin
                // Wait for user acknowledgement
                if (ack) begin
                    state <= WAIT_START;
                    done <= 0;
                end
            end
        endcase
    end
end

assign count = (state == COUNT_DOWN) ? counter : 4'bxxxx;

endmodule
