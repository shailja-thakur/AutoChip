module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

parameter [2:0] IDLE = 3'd0,
                DISC = 3'd1,
                FLAG = 3'd2,
                ERR = 3'd3;

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
            if (in == 1'b1) begin
                next_state = DISC;
            end else begin
                next_state = IDLE;
            end
        end
        DISC: begin
            if (in == 1'b0) begin
                next_state = IDLE;
                disc = 1'b1;
            end else if (in == 1'b1) begin
                next_state = FLAG;
            end else begin
                next_state = DISC;
            end
        end
        FLAG: begin
            if (in == 1'b0) begin
                next_state = IDLE;
                flag = 1'b1;
            end else if (in == 1'b1) begin
                next_state = ERR;
            end else begin
                next_state = FLAG;
            end
        end
        ERR: begin
            if (in == 1'b0) begin
                next_state = IDLE;
            end else begin
                next_state = ERR;
                err = 1'b1;
            end
        end
        default: begin
            next_state = IDLE;
        end
    endcase
end

endmodule
