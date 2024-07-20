module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

parameter [2:0] IDLE = 3'b000,
                DISCARDING = 3'b001,
                FLAGGING = 3'b010,
                ERRORING = 3'b011;

reg [2:0] state, next_state;
reg [2:0] count;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        count <= 0;
        disc <= 0;
        flag <= 0;
        err <= 0;
    end
    else begin
        state <= next_state;
        case (state)
            IDLE: begin
                if (in) begin
                    count <= 1;
                end
                else begin
                    count <= 0;
                end
                disc <= 0;
                flag <= 0;
                err <= 0;
            end
            DISCARDING: begin
                if (in) begin
                    count <= count + 1;
                    if (count == 5) begin
                        next_state <= IDLE;
                        disc <= 1;
                    end
                    else begin
                        next_state <= DISCARDING;
                    end
                end
                else begin
                    count <= 0;
                    next_state <= IDLE;
                    disc <= 0;
                end
                flag <= 0;
                err <= 0;
            end
            FLAGGING: begin
                if (in) begin
                    count <= count + 1;
                    if (count == 7) begin
                        next_state <= ERRORING;
                        err <= 1;
                    end
                    else begin
                        next_state <= FLAGGING;
                    end
                end
                else begin
                    count <= 0;
                    next_state <= IDLE;
                    flag <= 1;
                end
                disc <= 0;
            end
            ERRORING: begin
                if (in) begin
                    count <= count + 1;
                    next_state <= ERRORING;
                end
                else begin
                    count <= 0;
                    next_state <= IDLE;
                end
                disc <= 0;
                flag <= 0;
                err <= 1;
            end
        endcase
    end
end

endmodule
