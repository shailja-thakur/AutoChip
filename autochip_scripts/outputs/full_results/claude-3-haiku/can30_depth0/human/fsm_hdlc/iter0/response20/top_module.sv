module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

reg [2:0] state, next_state;
parameter IDLE = 3'b000, DISC = 3'b001, FLAG = 3'b010, ERR = 3'b011;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    disc = 0;
    flag = 0;
    err = 0;
    next_state = state;

    case (state)
        IDLE: begin
            if (in == 1'b1) begin
                next_state = DISC;
            end
            else begin
                next_state = IDLE;
            end
        end
        DISC: begin
            if (in == 1'b1) begin
                next_state = FLAG;
            end
            else begin
                next_state = IDLE;
                disc = 1;
            end
        end
        FLAG: begin
            if (in == 1'b1) begin
                next_state = ERR;
            end
            else begin
                next_state = IDLE;
                flag = 1;
            end
        end
        ERR: begin
            if (in == 1'b1) begin
                next_state = ERR;
            end
            else begin
                next_state = IDLE;
                err = 1;
            end
        end
    endcase
end

endmodule
