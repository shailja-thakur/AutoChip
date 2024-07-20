module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

localparam [2:0] IDLE = 3'd0,
                 DISCARD = 3'd1,
                 FLAG = 3'd2,
                 ERROR = 3'd3;

reg [2:0] state, next_state;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
    end else begin
        state <= next_state;
    end
end

always @(*) begin
    next_state = state;
    disc = 1'b0;
    flag = 1'b0;
    err = 1'b0;

    case (state)
        IDLE: begin
            if (in) begin
                next_state = DISCARD;
            end else begin
                next_state = IDLE;
            end
        end
        DISCARD: begin
            if (in) begin
                next_state = FLAG;
                disc = 1'b1;
            end else begin
                next_state = IDLE;
            end
        end
        FLAG: begin
            if (in) begin
                next_state = ERROR;
                flag = 1'b1;
            end else begin
                next_state = IDLE;
            end
        end
        ERROR: begin
            if (in) begin
                next_state = ERROR;
                err = 1'b1;
            end else begin
                next_state = IDLE;
            end
        end
        default: begin
            next_state = IDLE;
        end
    endcase
end

endmodule
