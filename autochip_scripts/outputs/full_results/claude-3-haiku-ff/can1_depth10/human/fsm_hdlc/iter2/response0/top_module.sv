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
reg [2:0] count;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        count <= 0;
    end else begin
        state <= next_state;
        if (in) begin
            count <= (count == 6) ? 0 : count + 1;
        end else begin
            count <= 0;
        end
    end
end

always @(*) begin
    next_state = state;
    disc = 1'b0;
    flag = 1'b0;
    err = 1'b0;

    case (state)
        IDLE: begin
            if (in == 1'b1) begin
                next_state = DISC;
            end
        end
        DISC: begin
            if (in == 1'b1) begin
                if (count == 5) begin
                    next_state = FLAG;
                    disc = 1'b1;
                end else begin
                    next_state = DISC;
                end
            end else begin
                next_state = IDLE;
            end
        end
        FLAG: begin
            if (in == 1'b1) begin
                if (count == 6) begin
                    next_state = IDLE;
                    flag = 1'b1;
                end else if (count == 7) begin
                    next_state = ERR;
                    err = 1'b1;
                end else begin
                    next_state = FLAG;
                end
            end else begin
                next_state = IDLE;
            end
        end
        ERR: begin
            if (in == 1'b0) begin
                next_state = IDLE;
            end
        end
        default: begin
            next_state = IDLE;
        end
    endcase
end

endmodule
