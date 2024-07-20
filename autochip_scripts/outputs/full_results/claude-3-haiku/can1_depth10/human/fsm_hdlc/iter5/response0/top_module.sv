module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

localparam [2:0] IDLE = 3'b000, 
                 FIVE_1S = 3'b001,
                 SIX_1S = 3'b010,
                 SEVEN_1S = 3'b011,
                 EIGHT_1S = 3'b100;

reg [2:0] state, next_state;

always @(posedge clk) begin
    if (reset)
        state <= IDLE;
    else
        state <= next_state;
end

always @(*) begin
    next_state = state;
    disc = 1'b0;
    flag = 1'b0;
    err = 1'b0;

    case (state)
        IDLE: begin
            if (in == 1'b1)
                next_state = FIVE_1S;
        end
        FIVE_1S: begin
            if (in == 1'b0)
                next_state = IDLE;
            else if (in == 1'b1)
                next_state = SIX_1S;
        end
        SIX_1S: begin
            if (in == 1'b0) begin
                next_state = IDLE;
                disc = 1'b1;
            end
            else if (in == 1'b1)
                next_state = SEVEN_1S;
        end
        SEVEN_1S: begin
            if (in == 1'b0) begin
                next_state = IDLE;
                flag = 1'b1;
            end
            else if (in == 1'b1)
                next_state = EIGHT_1S;
        end
        EIGHT_1S: begin
            if (in == 1'b0) begin
                next_state = IDLE;
                err = 1'b1;
            end
            else if (in == 1'b1)
                next_state = EIGHT_1S;
        end
    endcase
end

endmodule
