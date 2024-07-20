module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

localparam [2:0] IDLE = 3'b000,
                 BIT1 = 3'b001,
                 BIT2 = 3'b010,
                 BIT3 = 3'b011,
                 BIT4 = 3'b100,
                 BIT5 = 3'b101,
                 BIT6 = 3'b110,
                 BIT7 = 3'b111;

reg [2:0] state, next_state;

always @(posedge clk) begin
    if (reset)
        state <= IDLE;
    else
        state <= next_state;
end

always @(*) begin
    disc = 1'b0;
    flag = 1'b0;
    err = 1'b0;

    case (state)
        IDLE: begin
            if (in)
                next_state = BIT1;
            else
                next_state = IDLE;
        end
        BIT1: begin
            if (in)
                next_state = BIT2;
            else
                next_state = IDLE;
        end
        BIT2: begin
            if (in)
                next_state = BIT3;
            else
                next_state = IDLE;
        end
        BIT3: begin
            if (in)
                next_state = BIT4;
            else
                next_state = IDLE;
        end
        BIT4: begin
            if (in)
                next_state = BIT5;
            else
                next_state = IDLE;
        end
        BIT5: begin
            if (in)
                next_state = BIT6;
            else
                next_state = IDLE;
        end
        BIT6: begin
            if (in) begin
                next_state = BIT7;
                disc = 1'b1;
            end
            else
                next_state = IDLE;
        end
        BIT7: begin
            if (in)
                next_state = BIT7;
            else
                next_state = IDLE;
            err = 1'b1;
        end
    endcase

    if (state == BIT6 && !in)
        flag = 1'b1;
end

endmodule
