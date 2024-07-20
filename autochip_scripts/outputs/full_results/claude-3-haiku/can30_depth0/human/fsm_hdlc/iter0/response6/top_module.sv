module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

localparam [2:0] IDLE = 3'b000,
                DISCARDING = 3'b001,
                FLAGGING = 3'b010,
                ERRORING = 3'b011;

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
            if (in) begin
                next_state = DISCARDING;
            end else begin
                next_state = IDLE;
            end
        end
        DISCARDING: begin
            if (in) begin
                if (in) begin
                    next_state = FLAGGING;
                    disc = 1'b1;
                end else begin
                    next_state = IDLE;
                end
            end else begin
                next_state = IDLE;
            end
        end
        FLAGGING: begin
            if (in) begin
                if (in) begin
                    next_state = ERRORING;
                    flag = 1'b1;
                end else begin
                    next_state = IDLE;
                end
            end else begin
                next_state = IDLE;
            end
        end
        ERRORING: begin
            if (in) begin
                err = 1'b1;
                next_state = ERRORING;
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
