module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

reg [2:0] state;
parameter WAIT = 3'b000, DETECT_ONE = 3'b001, DETECT_TWO = 3'b010, DETECT_THREE = 3'b011, DETECT_FOUR = 3'b100, DETECT_FIVE = 3'b101, DETECT_SIX = 3'b110;

always @(posedge clk) begin
    if (reset) begin
        state <= WAIT;
        disc <= 0;
        flag <= 0;
        err <= 0;
    end
    else begin
        case (state)
            WAIT: begin
                if (in) begin
                    state <= DETECT_ONE;
                end
                else begin
                    state <= WAIT;
                end
                disc <= 0;
                flag <= 0;
                err <= 0;
            end
            DETECT_ONE: begin
                if (in) begin
                    state <= DETECT_TWO;
                end
                else begin
                    state <= WAIT;
                end
                disc <= 0;
                flag <= 0;
                err <= 0;
            end
            DETECT_TWO: begin
                if (in) begin
                    state <= DETECT_THREE;
                end
                else begin
                    state <= WAIT;
                end
                disc <= 0;
                flag <= 0;
                err <= 0;
            end
            DETECT_THREE: begin
                if (in) begin
                    state <= DETECT_FOUR;
                end
                else begin
                    state <= WAIT;
                end
                disc <= 0;
                flag <= 0;
                err <= 0;
            end
            DETECT_FOUR: begin
                if (in) begin
                    state <= DETECT_FIVE;
                end
                else begin
                    state <= WAIT;
                end
                disc <= 0;
                flag <= 0;
                err <= 0;
            end
            DETECT_FIVE: begin
                if (in) begin
                    state <= DETECT_SIX;
                end
                else begin
                    state <= WAIT;
                end
                disc <= 0;
                flag <= 0;
                err <= 0;
            end
            DETECT_SIX: begin
                if (in) begin
                    state <= DETECT_ONE;
                    disc <= 1;
                    flag <= 1;
                    err <= 0;
                end
                else begin
                    state <= WAIT;
                    disc <= 0;
                    flag <= 0;
                    err <= 1;
                end
            end
            default: begin
                state <= WAIT;
                disc <= 0;
                flag <= 0;
                err <= 0;
            end
        endcase
    end
end

endmodule
