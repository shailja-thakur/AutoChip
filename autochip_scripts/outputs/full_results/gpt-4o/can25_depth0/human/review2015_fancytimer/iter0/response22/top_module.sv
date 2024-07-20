module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

    reg [3:0] state;
    reg [3:0] delay;
    reg [13:0] counter;
    reg [3:0] count_reg;
    reg [3:0] shift_reg;

    localparam IDLE = 4'd0,
               DETECT_1 = 4'd1,
               DETECT_11 = 4'd2,
               DETECT_110 = 4'd3,
               DETECT_1101 = 4'd4,
               LOAD_DELAY = 4'd5,
               COUNTING = 4'd6,
               WAIT_ACK = 4'd7;

    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            counting <= 1'b0;
            done <= 1'b0;
            counter <= 14'd0;
            count_reg <= 4'd0;
            shift_reg <= 4'd0;
            delay <= 4'd0;
        end else begin
            case (state)
                IDLE: begin
                    if (data == 1'b1) begin
                        state <= DETECT_1;
                    end
                end
                DETECT_1: begin
                    if (data == 1'b1) begin
                        state <= DETECT_11;
                    end else begin
                        state <= IDLE;
                    end
                end
                DETECT_11: begin
                    if (data == 1'b0) begin
                        state <= DETECT_110;
                    end else begin
                        state <= IDLE;
                    end
                end
                DETECT_110: begin
                    if (data == 1'b1) begin
                        state <= DETECT_1101;
                    end else begin
                        state <= IDLE;
                    end
                end
                DETECT_1101: begin
                    shift_reg <= {shift_reg[2:0], data};
                    if (shift_reg[3]) begin
                        delay <= shift_reg;
                        state <= LOAD_DELAY;
                    end else begin
                        state <= IDLE;
                    end
                end
                LOAD_DELAY: begin
                    counter <= (delay + 1'b1) * 1000;
                    counting <= 1'b1;
                    state <= COUNTING;
                end
                COUNTING: begin
                    if (counter > 0) begin
                        counter <= counter - 1'b1;
                        count_reg <= counter / 1000;
                    end else begin
                        counting <= 1'b0;
                        done <= 1'b1;
                        state <= WAIT_ACK;
                    end
                end
                WAIT_ACK: begin
                    if (ack == 1'b1) begin
                        done <= 1'b0;
                        state <= IDLE;
                    end
                end
            endcase
        end
    end

    assign count = (counting) ? count_reg : 4'bxxxx;

endmodule
