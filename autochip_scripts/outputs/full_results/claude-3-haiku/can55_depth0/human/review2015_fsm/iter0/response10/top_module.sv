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

localparam [3:0] WAIT_START = 4'b0000,
                 SHIFT_BITS = 4'b0001,
                 COUNT     = 4'b0010,
                 WAIT_ACK  = 4'b0011;

reg [3:0] state, next_state;
reg [3:0] shift_reg;

always @(posedge clk) begin
    if (reset) begin
        state <= WAIT_START;
        shift_reg <= 4'b0000;
    end
    else begin
        state <= next_state;
        shift_reg <= {shift_reg[2:0], data};
    end
end

always @(*) begin
    next_state = state;
    shift_ena = 1'b0;
    counting = 1'b0;
    done = 1'b0;

    case (state)
        WAIT_START: begin
            if (shift_reg == 4'b1101) begin
                next_state = SHIFT_BITS;
                shift_ena = 1'b1;
            end
        end
        SHIFT_BITS: begin
            shift_ena = 1'b1;
            if (shift_reg[3:0] == 4'b1111) begin
                next_state = COUNT;
            end
        end
        COUNT: begin
            counting = 1'b1;
            if (done_counting) begin
                next_state = WAIT_ACK;
                done = 1'b1;
            end
        end
        WAIT_ACK: begin
            if (ack) begin
                next_state = WAIT_START;
            end
        end
    endcase
end

endmodule
