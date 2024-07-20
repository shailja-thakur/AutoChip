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

localparam [2:0] IDLE = 3'b000, 
                 START_SEQ = 3'b001, 
                 SHIFT_EN = 3'b010,
                 COUNTING = 3'b011,
                 DONE = 3'b100;

reg [2:0] state, next_state;
reg [3:0] pattern;
reg [3:0] shift_count;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        pattern <= 4'b0;
        shift_count <= 4'b0;
    end
    else begin
        state <= next_state;
        pattern <= {pattern[2:0], data};
        if (state == SHIFT_EN) begin
            shift_count <= shift_count + 1;
        end
        else begin
            shift_count <= 4'b0;
        end
    end
end

always @(*) begin
    next_state = state;
    shift_ena = 1'b0;
    counting = 1'b0;
    done = 1'b0;

    case (state)
        IDLE: begin
            if (pattern == 4'b1101) begin
                next_state = START_SEQ;
            end
        end

        START_SEQ: begin
            shift_ena = 1'b1;
            next_state = SHIFT_EN;
        end

        SHIFT_EN: begin
            shift_ena = 1'b1;
            if (shift_count == 4'd4) begin
                next_state = COUNTING;
            end
        end

        COUNTING: begin
            counting = 1'b1;
            if (done_counting) begin
                next_state = DONE;
            end
        end

        DONE: begin
            done = 1'b1;
            if (ack) begin
                next_state = IDLE;
            end
        end
    endcase
end

endmodule
