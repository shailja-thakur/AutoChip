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

localparam [3:0] WAIT_START  = 0,
                 SHIFT_DELAY = 1,
                 COUNTING    = 2,
                 DONE        = 3;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= WAIT_START;
        counting <= 0;
        done <= 0;
        shift_reg <= 0;
        delay <= 0;
        counter <= 0;
    end
    else begin
        case (state)
            WAIT_START: begin
                // Shift in 4-bit pattern
                shift_reg <= {shift_reg[2:0], data};
                if (shift_reg == 4'b1101) begin
                    state <= SHIFT_DELAY;
                end
            end
            SHIFT_DELAY: begin
                // Shift in delay value
                shift_reg <= {shift_reg[2:0], data};
                if (shift_reg[3:0] == 4'b1111) begin
                    delay <= shift_reg[3:0];
                    state <= COUNTING;
                    counting <= 1;
                    counter <= 0;
                end
            end
            COUNTING: begin
                counter <= counter + 1;
                if (counter == (delay + 1) * 250 - 1) begin // 1000 cycles
                    counting <= 0;
                    if (delay == 0) begin
                        state <= DONE;
                        done <= 1;
                    end
                    else begin
                        delay <= delay - 1;
                        counter <= 0;
                    end
                end
            end
            DONE: begin
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
