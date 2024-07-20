module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack
);

parameter WAIT_START = 3'b000;
parameter SHIFT_BITS = 3'b001;
parameter WAIT_DONE  = 3'b010;
parameter NOTIFY     = 3'b011;

reg [2:0] state, next_state;
reg [3:0] shift_reg;

always @(posedge clk) begin
    if (reset) begin
        state <= WAIT_START;
        shift_reg <= 0;
    end
    else begin
        state <= next_state;
        shift_reg <= {shift_reg[2:0], data};
    end
end

always @(*) begin
    next_state = state;
    shift_ena = 0;
    counting = 0;
    done = 0;

    case (state)
        WAIT_START: begin
            if (shift_reg == 4'b1101) begin
                next_state = SHIFT_BITS;
                shift_ena = 1;
            end
        end
        SHIFT_BITS: begin
            shift_ena = 1;
            if (shift_reg[3:0] == 4'b1111) begin
                next_state = WAIT_DONE;
            end
        end
        WAIT_DONE: begin
            counting = 1;
            if (done_counting) begin
                next_state = NOTIFY;
            end
        end
        NOTIFY: begin
            done = 1;
            if (ack) begin
                next_state = WAIT_START;
            end
        end
    endcase
end

endmodule
