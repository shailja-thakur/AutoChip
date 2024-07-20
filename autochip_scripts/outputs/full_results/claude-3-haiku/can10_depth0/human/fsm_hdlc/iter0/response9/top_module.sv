module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

localparam [2:0] 
    S_START = 3'b000,
    S_ONE   = 3'b001,
    S_TWO   = 3'b010,
    S_THREE = 3'b011,
    S_FOUR  = 3'b100,
    S_FIVE  = 3'b101,
    S_SIX   = 3'b110,
    S_ERR   = 3'b111;

reg [2:0] state, next_state;

always @(posedge clk) begin
    if (reset)
        state <= S_START;
    else
        state <= next_state;
end

always @(*) begin
    disc = 1'b0;
    flag = 1'b0;
    err = 1'b0;

    case (state)
        S_START: begin
            if (in == 1'b0)
                next_state = S_START;
            else
                next_state = S_ONE;
        end
        S_ONE: begin
            if (in == 1'b0)
                next_state = S_START;
            else
                next_state = S_TWO;
        end
        S_TWO: begin
            if (in == 1'b0)
                next_state = S_START;
            else
                next_state = S_THREE;
        end
        S_THREE: begin
            if (in == 1'b0)
                next_state = S_START;
            else
                next_state = S_FOUR;
        end
        S_FOUR: begin
            if (in == 1'b0)
                next_state = S_START;
            else
                next_state = S_FIVE;
        end
        S_FIVE: begin
            if (in == 1'b0) begin
                next_state = S_START;
                disc = 1'b1;
            end
            else
                next_state = S_SIX;
        end
        S_SIX: begin
            if (in == 1'b0) begin
                next_state = S_START;
                flag = 1'b1;
            end
            else
                next_state = S_ERR;
        end
        S_ERR: begin
            if (in == 1'b0)
                next_state = S_START;
            else
                next_state = S_ERR;
            err = 1'b1;
        end
        default:
            next_state = S_START;
    endcase
end

endmodule
