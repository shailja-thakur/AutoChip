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

parameter IDLE = 4'd0;
parameter DETECT_PATTERN = 4'd1;
parameter SHIFT_DELAY = 4'd2;
parameter COUNTDOWN = 4'd3;
parameter WAIT_ACK = 4'd4;

always @(posedge clk or posedge reset) begin
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
                if (shift_reg == 4'b1101) begin
                    state <= DETECT_PATTERN;
                    shift_reg <= 0;
                end else begin
                    shift_reg <= {shift_reg[2:0], data};
                end
            end
            DETECT_PATTERN: begin
                state <= SHIFT_DELAY;
            end
            SHIFT_DELAY: begin
                if (counter == 4'b0011) begin
                    delay <= shift_reg;
                    state <= COUNTDOWN;
                    counting <= 1;
                    counter <= 0;
                    shift_reg <= 0;
                end else begin
                    shift_reg <= {shift_reg[2:0], data};
                    counter <= counter + 1;
                end
            end
            COUNTDOWN: begin
                if (counter == delay) begin
                    counting <= 0;
                    done <= 1;
                    state <= WAIT_ACK;
                    counter <= 0;
                end else begin
                    counter <= counter + 1;
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

assign count = counting ? delay - counter : 4'bxxxx;

endmodule
