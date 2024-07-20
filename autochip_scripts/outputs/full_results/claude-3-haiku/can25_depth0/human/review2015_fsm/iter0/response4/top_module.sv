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

parameter [3:0] IDLE = 4'b0000, 
                DETECT_START = 4'b0001,
                SHIFT_DATA = 4'b0010, 
                COUNTING = 4'b0011,
                NOTIFY_USER = 4'b0100;

reg [3:0] state, next_state;
reg [3:0] shift_reg;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
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
        IDLE: begin
            if (shift_reg == 4'b1101) begin
                next_state = SHIFT_DATA;
                shift_ena = 1'b1;
            end
        end
        SHIFT_DATA: begin
            shift_ena = 1'b1;
            if (shift_reg[3:0] == 4'b1111) begin
                next_state = COUNTING;
            end
        end
        COUNTING: begin
            counting = 1'b1;
            if (done_counting) begin
                next_state = NOTIFY_USER;
            end
        end
        NOTIFY_USER: begin
            done = 1'b1;
            if (ack) begin
                next_state = IDLE;
            end
        end
    endcase
end

endmodule
