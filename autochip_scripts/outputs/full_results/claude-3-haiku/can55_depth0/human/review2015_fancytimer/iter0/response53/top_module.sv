module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

    // States
    localparam [2:0] STATE_IDLE = 3'b000,
                    STATE_DETECT_START = 3'b001,
                    STATE_SHIFT_DURATION = 3'b010,
                    STATE_COUNT_DOWN = 3'b011,
                    STATE_DONE = 3'b100;

    // Registers
    reg [2:0] state;
    reg [3:0] shift_reg;
    reg [15:0] timer;
    reg [3:0] delay;

    // Combinational outputs
    assign count = (state == STATE_COUNT_DOWN) ? (delay - (timer / 1000)) : 4'b0; // Remaining time

    // State machine
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= STATE_IDLE;
            counting <= 0;
            done <= 0;
        end else begin
            case (state)
                STATE_IDLE: begin
                    if (data == 1'b1) shift_reg <= {shift_reg[2:0], data};
                    if (shift_reg == 4'b1101) begin
                        state <= STATE_DETECT_START;
                        shift_reg <= 4'b0;
                    end
                end
                STATE_DETECT_START: begin
                    if (data == 1'b1) shift_reg <= {shift_reg[2:0], data};
                    if (shift_reg == 4'b0) begin
                        state <= STATE_SHIFT_DURATION;
                        delay <= shift_reg;
                        timer <= 0;
                        counting <= 1;
                    end
                end
                STATE_SHIFT_DURATION: begin
                    if (data == 1'b1) shift_reg <= {shift_reg[2:0], data};
                    if (shift_reg == 4'b0) begin
                        state <= STATE_COUNT_DOWN;
                    end
                end
                STATE_COUNT_DOWN: begin
                    timer <= timer + 16'd1;
                    if (timer >= (delay + 1) * 16'd1000) begin
                        state <= STATE_DONE;
                        counting <= 0;
                        done <= 1;
                    end
                end
                STATE_DONE: begin
                    if (ack) begin
                        state <= STATE_IDLE;
                        done <= 0;
                    end
                end
                default: state <= STATE_IDLE;
            endcase
        end
    end

endmodule
