module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

localparam [2:0] // State encoding
    S_IDLE = 3'b000,
    S_1 = 3'b001,
    S_11 = 3'b010,
    S_111 = 3'b011,
    S_1111 = 3'b100,
    S_11111 = 3'b101,
    S_111110 = 3'b110,
    S_111111 = 3'b111;

reg [2:0] state, next_state;

always @(posedge clk) begin
    if (reset)
        state <= S_IDLE;
    else
        state <= next_state;
end

always @(*) begin
    disc = 1'b0;
    flag = 1'b0;
    err = 1'b0;

    case (state)
        S_IDLE: begin
            if (in == 1'b1)
                next_state = S_1;
            else
                next_state = S_IDLE;
        end
        S_1: begin
            if (in == 1'b1)
                next_state = S_11;
            else
                next_state = S_IDLE;
        end
        S_11: begin
            if (in == 1'b1)
                next_state = S_111;
            else
                next_state = S_IDLE;
        end
        S_111: begin
            if (in == 1'b1)
                next_state = S_1111;
            else
                next_state = S_IDLE;
        end
        S_1111: begin
            if (in == 1'b1)
                next_state = S_11111;
            else
                next_state = S_IDLE;
        end
        S_11111: begin
            if (in == 1'b0)
                next_state = S_IDLE;
            else
                next_state = S_111110;
        end
        S_111110: begin
            if (in == 1'b0)
                next_state = S_IDLE;
            else
                next_state = S_111111;
        end
        S_111111: begin
            if (in == 1'b0)
                next_state = S_IDLE;
            else
                next_state = S_111111;
        end
    endcase

    case (state)
        S_111110: begin
            disc = 1'b1;
        end
        S_111111: begin
            err = 1'b1;
        end
        S_11111: begin
            flag = 1'b1;
        end
    endcase
end

endmodule
