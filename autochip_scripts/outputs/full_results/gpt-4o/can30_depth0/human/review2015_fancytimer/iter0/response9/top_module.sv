module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    reg [2:0] state, next_state;
    reg [7:0] shift_reg;
    reg [15:0] timer;
    reg [3:0] delay;

    // State Definitions
    localparam [2:0]
        WAITING_PATTERN = 3'b000,
        CAPTURE_DELAY   = 3'b001,
        COUNTING        = 3'b010,
        TIMER_DONE      = 3'b011;

    // Shift register
    always @(posedge clk) begin
        if (reset) begin
            shift_reg <= 8'b0;
        end else if (state == WAITING_PATTERN) begin
            shift_reg <= {shift_reg[6:0], data};
        end
    end

    // State transition
    always @(posedge clk) begin
        if (reset) begin
            state <= WAITING_PATTERN;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        next_state = state;
        case (state)
            WAITING_PATTERN: begin
                if (shift_reg[7:4] == 4'b1101) begin
                    next_state = CAPTURE_DELAY;
                end
            end
            CAPTURE_DELAY: begin
                next_state = COUNTING;
            end
            COUNTING: begin
                if (timer == 0) begin
                    next_state = TIMER_DONE;
                end
            end
            TIMER_DONE: begin
                if (ack) begin
                    next_state = WAITING_PATTERN;
                end
            end
        endcase
    end

    // Output logic and delay capture
    always @(posedge clk) begin
        if (reset) begin
            delay <= 4'd0;
            count <= 4'd0;
            timer <= 16'd0;
            counting <= 1'b0;
            done <= 1'b0;
        end else begin
            case (state)
                WAITING_PATTERN: begin
                    if (shift_reg[7:4] == 4'b1101) begin
                        delay <= {shift_reg[3:0]};
                    end
                    count <= 4'd0;
                    counting <= 1'b0;
                    done <= 1'b0;
                end
                CAPTURE_DELAY: begin
                    timer <= (delay + 16'd1) * 16'd1000;
                    count <= delay;
                end
                COUNTING: begin
                    counting <= 1'b1;
                    if (timer != 0) begin
                        timer <= timer - 1;
                    end
                    if (timer % 1000 == 0) begin
                        count <= count - 1;
                    end
                end
                TIMER_DONE: begin
                    counting <= 1'b0;
                    done <= 1'b1;
                    count <= 4'd0;
                end
            endcase
        end
    end

endmodule
