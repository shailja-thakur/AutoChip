module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

// States for the state machine
localparam [2:0] IDLE = 3'd0, DETECT_PATTERN = 3'd1, SHIFT_IN_DELAY = 3'd2, COUNT_DOWN = 3'd3, WAIT_ACK = 3'd4;

reg [2:0] state;
reg [3:0] pattern_shift_reg;
reg [3:0] delay;
reg [15:0] counter;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        counting <= 0;
        done <= 0;
        pattern_shift_reg <= 0;
        delay <= 0;
        counter <= 0;
    end else begin
        case (state)
            IDLE: begin
                if (pattern_shift_reg == 4'b1101) begin
                    state <= SHIFT_IN_DELAY;
                    pattern_shift_reg <= 0;
                end else begin
                    pattern_shift_reg <= {pattern_shift_reg[2:0], data};
                end
            end
            SHIFT_IN_DELAY: begin
                if (pattern_shift_reg == 4'b0000) begin
                    delay <= 4'b0001;
                    state <= COUNT_DOWN;
                    counting <= 1;
                end else begin
                    delay <= {delay[2:0], data};
                    pattern_shift_reg <= {pattern_shift_reg[2:0], data};
                end
            end
            COUNT_DOWN: begin
                counter <= counter + 1;
                if (counter == (delay + 1) * 16'd1000 - 1) begin
                    state <= WAIT_ACK;
                    counting <= 0;
                    done <= 1;
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

assign count = delay - (counter / 1000);

endmodule
