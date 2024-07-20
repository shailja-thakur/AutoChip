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

parameter IDLE = 4'b0000;
parameter DETECT_PATTERN = 4'b0001;
parameter CAPTURE_DELAY = 4'b0010;
parameter COUNT_DOWN = 4'b0011;
parameter NOTIFY = 4'b0100;
parameter WAIT_ACK = 4'b0101;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
        counting <= 0;
        done <= 0;
        delay <= 0;
        counter <= 0;
        shift_reg <= 0;
    end
    else begin
        case (state)
            IDLE: begin
                shift_reg <= {shift_reg[2:0], data};
                if (shift_reg == 4'b1101) begin
                    state <= DETECT_PATTERN;
                end
            end
            DETECT_PATTERN: begin
                shift_reg <= {shift_reg[2:0], data};
                if (shift_reg == 4'b1111) begin
                    state <= CAPTURE_DELAY;
                end
            end
            CAPTURE_DELAY: begin
                shift_reg <= {shift_reg[2:0], data};
                delay <= shift_reg[3:0];
                state <= COUNT_DOWN;
                counting <= 1;
            end
            COUNT_DOWN: begin
                counter <= counter + 1;
                count <= delay - (counter / 1000);
                if (counter == (delay + 1) * 1000 - 1) begin
                    state <= NOTIFY;
                    counting <= 0;
                end
            end
            NOTIFY: begin
                done <= 1;
                state <= WAIT_ACK;
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

endmodule
