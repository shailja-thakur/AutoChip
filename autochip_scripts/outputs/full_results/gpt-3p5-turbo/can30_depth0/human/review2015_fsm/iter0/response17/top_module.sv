module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack );

reg [3:0] state;
reg [3:0] next_state;

parameter IDLE = 4'b0000;
parameter DETECTED = 4'b0001;
parameter SHIFTING = 4'b0010;
parameter COUNTING = 4'b0011;
parameter TIMEOUT = 4'b0100;
parameter WAIT_ACK = 4'b0101;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
    end else begin
        state <= next_state;
    end
end

always @(*) begin
    next_state = state;

    case (state)
        IDLE: begin
            if (data == 4'b1101) begin
                next_state = DETECTED;
            end
        end

        DETECTED: begin
            shift_ena = 1;
            next_state = SHIFTING;
        end

        SHIFTING: begin
            shift_ena = 1;
            next_state = COUNTING;
        end

        COUNTING: begin
            shift_ena = 0;
            counting = 1;
            if (done_counting) begin
                next_state = TIMEOUT;
            end
        end

        TIMEOUT: begin
            done = 1;
            next_state = WAIT_ACK;
        end

        WAIT_ACK: begin
            shift_ena = 0;
            counting = 0;
            done = 0;
            if (ack) begin
                next_state = IDLE;
            end
        end
    endcase
end

endmodule
