module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

localparam [2:0] IDLE = 3'b000,
                 DISC = 3'b001,
                 FLAG = 3'b010,
                 ERR = 3'b011;

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
            if (in == 1'b0)
                next_state = IDLE;
            else
                next_state = DISC;
        end
        DISC: begin
            if (in == 1'b0) begin
                next_state = IDLE;
                disc = 1'b1;
            end
            else
                next_state = FLAG;
        end
        FLAG: begin
            if (in == 1'b0) begin
                next_state = IDLE;
                flag = 1'b1;
            end
            else if (in == 1'b1)
                next_state = ERR;
            else
                next_state = FLAG;
        end
        ERR: begin
            err = 1'b1;
            next_state = IDLE;
        end
        default: next_state = IDLE;
    endcase
end

endmodule
