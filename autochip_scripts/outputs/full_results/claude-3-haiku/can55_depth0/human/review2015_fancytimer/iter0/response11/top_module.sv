module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

localparam ST_IDLE = 2'b00, ST_DETECT = 2'b01, ST_COUNT = 2'b10, ST_WAIT = 2'b11;
reg [1:0] state, next_state;
reg [3:0] shift_reg;
reg [11:0] counter;
reg [3:0] delay;

always @(posedge clk) begin
    if (reset) begin
        state <= ST_IDLE;
        counting <= 0;
        done <= 0;
        shift_reg <= 0;
        counter <= 0;
        delay <= 0;
    end else begin
        state <= next_state;
        case (state)
            ST_IDLE: begin
                if (shift_reg[3:0] == 4'b1101) begin
                    next_state <= ST_DETECT;
                    shift_reg <= {shift_reg[2:0], data};
                end else begin
                    next_state <= ST_IDLE;
                    shift_reg <= {shift_reg[2:0], data};
                end
                counting <= 0;
                done <= 0;
            end
            ST_DETECT: begin
                if (counter == 4) begin
                    next_state <= ST_COUNT;
                    delay <= shift_reg[3:0];
                    counter <= 0;
                    shift_reg <= 0;
                end else begin
                    next_state <= ST_DETECT;
                    shift_reg <= {shift_reg[2:0], data};
                    counter <= counter + 1;
                end
                counting <= 0;
                done <= 0;
            end
            ST_COUNT: begin
                if (counter == (delay + 1) * 1000 - 1) begin
                    next_state <= ST_WAIT;
                    counting <= 0;
                    done <= 1;
                    counter <= 0;
                end else begin
                    next_state <= ST_COUNT;
                    counting <= 1;
                    done <= 0;
                    counter <= counter + 1;
                end
            end
            ST_WAIT: begin
                if (ack) begin
                    next_state <= ST_IDLE;
                    counting <= 0;
                    done <= 0;
                end else begin
                    next_state <= ST_WAIT;
                end
            end
        endcase
    end
end

assign count = (state == ST_COUNT) ? delay - (counter / 1000) : 0;

endmodule
