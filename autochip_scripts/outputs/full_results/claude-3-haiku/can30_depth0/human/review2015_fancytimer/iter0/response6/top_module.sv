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
    reg [3:0] shift_reg;
    reg [1:0] state;

    localparam IDLE = 2'b00;
    localparam SHIFT_IN = 2'b01;
    localparam COUNTING = 2'b10;
    localparam WAIT_ACK = 2'b11;

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
                    // Shift in the start pattern (1101)
                    shift_reg <= {shift_reg[2:0], data};
                    if (shift_reg == 4'b1101) begin
                        state <= SHIFT_IN;
                    end
                end
                SHIFT_IN: begin
                    // Shift in the 4-bit delay value
                    shift_reg <= {shift_reg[2:0], data};
                    if (counter == 4'd3) begin
                        delay <= shift_reg;
                        state <= COUNTING;
                        counting <= 1;
                        counter <= 0;
                    end else begin
                        counter <= counter + 1;
                    end
                end
                COUNTING: begin
                    // Countdown the timer
                    if (counter == delay) begin
                        counter <= 0;
                        if (delay == 0) begin
                            state <= WAIT_ACK;
                            counting <= 0;
                            done <= 1;
                        end else begin
                            delay <= delay - 1;
                        end
                    end else begin
                        counter <= counter + 1;
                    end
                end
                WAIT_ACK: begin
                    // Wait for user acknowledgement
                    if (ack) begin
                        state <= IDLE;
                        done <= 0;
                    end
                end
                default: begin
                    state <= IDLE;
                end
            endcase
        end
    end

    assign count = (state == COUNTING) ? delay : 4'bxxxx;

endmodule
