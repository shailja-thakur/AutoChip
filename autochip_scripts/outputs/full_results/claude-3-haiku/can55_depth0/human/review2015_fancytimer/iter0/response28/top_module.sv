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
reg [11:0] timer_count;
reg [3:0] state;
reg [3:0] shift_reg;

localparam [3:0]
    IDLE = 4'd0,
    DETECT_PATTERN = 4'd1,
    LOAD_DELAY = 4'd2,
    COUNT_DOWN = 4'd3,
    WAIT_ACK = 4'd4;

assign count = (state == COUNT_DOWN) ? delay - (timer_count / 1000) : 4'bxxxx;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
        counting <= 1'b0;
        done <= 1'b0;
        shift_reg <= 4'b0;
        delay <= 4'b0;
        timer_count <= 12'b0;
    end
    else begin
        case (state)
            IDLE: begin
                counting <= 1'b0;
                done <= 1'b0;
                if (shift_reg == 4'b1101) begin
                    state <= LOAD_DELAY;
                end
                else begin
                    shift_reg <= {shift_reg[2:0], data};
                end
            end
            LOAD_DELAY: begin
                shift_reg <= {shift_reg[2:0], data};
                if (shift_reg[3:0] == 4'b1111) begin
                    delay <= shift_reg[7:4];
                    state <= COUNT_DOWN;
                    counting <= 1'b1;
                    timer_count <= 12'b0;
                end
            end
            COUNT_DOWN: begin
                timer_count <= timer_count + 12'd1;
                if (timer_count == ((delay + 1) * 12'd1000 - 1)) begin
                    counting <= 1'b0;
                    done <= 1'b1;
                    state <= WAIT_ACK;
                end
            end
            WAIT_ACK: begin
                if (ack) begin
                    state <= IDLE;
                end
            end
            default: begin
                state <= IDLE;
            end
        endcase
    end
end

endmodule
