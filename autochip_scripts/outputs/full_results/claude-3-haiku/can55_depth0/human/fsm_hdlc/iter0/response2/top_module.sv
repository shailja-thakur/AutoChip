module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

reg [2:0] state, next_state;
parameter WAIT = 3'b000, DISC = 3'b001, FLAG = 3'b010, ERR = 3'b011;

always @(posedge clk) begin
    if (reset) begin
        state <= WAIT;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    disc = 0;
    flag = 0;
    err = 0;
    case (state)
        WAIT: begin
            if (in) begin
                next_state = DISC;
            end
            else begin
                next_state = WAIT;
            end
        end
        DISC: begin
            disc = 1;
            if (in) begin
                next_state = DISC;
            end
            else begin
                next_state = WAIT;
            end
        end
        FLAG: begin
            flag = 1;
            if (in) begin
                next_state = ERR;
            end
            else begin
                next_state = WAIT;
            end
        end
        ERR: begin
            err = 1;
            if (in) begin
                next_state = ERR;
            end
            else begin
                next_state = WAIT;
            end
        end
        default: begin
            next_state = WAIT;
        end
    endcase
end

endmodule
