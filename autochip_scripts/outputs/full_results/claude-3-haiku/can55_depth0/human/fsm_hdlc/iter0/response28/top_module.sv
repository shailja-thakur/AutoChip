module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

parameter [2:0] S_IDLE = 3'b000,
                S_ONE  = 3'b001,
                S_TWO  = 3'b010,
                S_THR  = 3'b011,
                S_FOU  = 3'b100,
                S_FIV  = 3'b101,
                S_SIX  = 3'b110;

reg [2:0] state, next_state;

always @ (posedge clk or posedge reset) begin
    if (reset) begin
        state <= S_IDLE;
    end
    else begin
        state <= next_state;
    end
end

always @ (*) begin
    next_state = state;
    disc = 1'b0;
    flag = 1'b0;
    err = 1'b0;
    case (state)
        S_IDLE: begin
            if (in == 1'b1) begin
                next_state = S_ONE;
            end
        end
        S_ONE: begin
            if (in == 1'b1) begin
                next_state = S_TWO;
            end
            else begin
                next_state = S_IDLE;
            end
        end
        S_TWO: begin
            if (in == 1'b1) begin
                next_state = S_THR;
            end
            else begin
                next_state = S_IDLE;
            end
        end
        S_THR: begin
            if (in == 1'b1) begin
                next_state = S_FOU;
            end
            else begin
                next_state = S_IDLE;
            end
        end
        S_FOU: begin
            if (in == 1'b1) begin
                next_state = S_FIV;
            end
            else begin
                next_state = S_IDLE;
            end
        end
        S_FIV: begin
            if (in == 1'b0) begin
                next_state = S_IDLE;
                disc = 1'b1;
            end
            else begin
                next_state = S_SIX;
            end
        end
        S_SIX: begin
            if (in == 1'b1) begin
                next_state = S_SIX;
                flag = 1'b1;
            end
            else begin
                next_state = S_IDLE;
            end
        end
        default: begin
            if (in == 1'b1) begin
                next_state = S_SIX;
                err = 1'b1;
            end
            else begin
                next_state = S_IDLE;
            end
        end
    endcase
end

endmodule
