module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

parameter [2:0] IDLE = 3'b000,
                DISC = 3'b001,
                FLAG = 3'b010,
                ERR  = 3'b011;

reg [2:0] state, next_state;

always @(posedge clk) begin
    if (reset)
        state <= IDLE;
    else
        state <= next_state;
end

always @(*) begin
    next_state = state;
    disc = 0;
    flag = 0;
    err = 0;

    case (state)
        IDLE: begin
            if (in == 1'b1) begin
                next_state = DISC;
            end
        end
        DISC: begin
            if (in == 1'b1) begin
                if (next_state == DISC) begin
                    next_state = FLAG;
                end else begin
                    next_state = ERR;
                end
            end else begin
                next_state = IDLE;
            end
            disc = 1;
        end
        FLAG: begin
            if (in == 1'b1) begin
                next_state = ERR;
            end else begin
                next_state = IDLE;
            end
            flag = 1;
        end
        ERR: begin
            err = 1;
            next_state = IDLE;
        end
    endcase
end

endmodule
