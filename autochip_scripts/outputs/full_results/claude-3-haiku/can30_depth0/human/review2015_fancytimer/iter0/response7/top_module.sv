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

localparam [3:0] IDLE = 4'b0000,
                 DETECT_PATTERN = 4'b0001,
                 SHIFT_DELAY = 4'b0010,
                 COUNTING = 4'b0011,
                 WAIT_ACK = 4'b0100;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        counting <= 0;
        done <= 0;
        shift_reg <= 0;
        delay <= 0;
        counter <= 0;
    end else begin
        case (state)
            IDLE: begin
                if (shift_reg[3:0] == 4'b1101) begin
                    state <= DETECT_PATTERN;
                    shift_reg <= {shift_reg[2:0], data};
                end else begin
                    shift_reg <= {shift_reg[2:0], data};
                end
            end
            DETECT_PATTERN: begin
                if (shift_reg[3:0] == 4'b1101) begin
                    state <= SHIFT_DELAY;
                    shift_reg <= {shift_reg[2:0], data};
                end else begin
                    state <= IDLE;
                    shift_reg <= {shift_reg[2:0], data};
                end
            end
            SHIFT_DELAY: begin
                delay <= {shift_reg[3], shift_reg[2], shift_reg[1], shift_reg[0]};
                state <= COUNTING;
                counting <= 1;
                counter <= 0;
            end
            COUNTING: begin
                counter <= counter + 1;
                if (counter == (delay + 1) * 250 - 1) begin // 1000 cycles
                    counting <= 0;
                    done <= 1;
                    state <= WAIT_ACK;
                end
            end
            WAIT_ACK: begin
                if (ack) begin
                    state <= IDLE;
                    done <= 0;
                end
            end
        endcase
    end
end

assign count = counter / 250; // Return the current remaining time

endmodule
