module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

localparam [2:0] IDLE = 3'b000,
                 ONE = 3'b001,
                 TWO = 3'b010,
                 THREE = 3'b011,
                 FOUR = 3'b100,
                 FIVE = 3'b101,
                 SIX = 3'b110,
                 SEVEN = 3'b111;

reg [2:0] state, next_state;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        disc <= 0;
        flag <= 0;
        err <= 0;
    end
    else begin
        state <= next_state;
        case (state)
            IDLE: begin
                disc <= 0;
                flag <= 0;
                err <= 0;
            end
            ONE: begin
                if (in) begin
                    disc <= 0;
                    flag <= 0;
                    err <= 0;
                end
                else begin
                    disc <= 0;
                    flag <= 0;
                    err <= 0;
                end
            end
            TWO: begin
                if (in) begin
                    disc <= 0;
                    flag <= 0;
                    err <= 0;
                end
                else begin
                    disc <= 0;
                    flag <= 0;
                    err <= 0;
                end
            end
            THREE: begin
                if (in) begin
                    disc <= 0;
                    flag <= 0;
                    err <= 0;
                end
                else begin
                    disc <= 0;
                    flag <= 0;
                    err <= 0;
                end
            end
            FOUR: begin
                if (in) begin
                    disc <= 0;
                    flag <= 0;
                    err <= 0;
                end
                else begin
                    disc <= 1;
                    flag <= 0;
                    err <= 0;
                end
            end
            FIVE: begin
                if (in) begin
                    disc <= 0;
                    flag <= 1;
                    err <= 0;
                end
                else begin
                    disc <= 0;
                    flag <= 0;
                    err <= 0;
                end
            end
            SIX: begin
                if (in) begin
                    disc <= 0;
                    flag <= 0;
                    err <= 1;
                end
                else begin
                    disc <= 0;
                    flag <= 0;
                    err <= 0;
                end
            end
            SEVEN: begin
                if (in) begin
                    disc <= 0;
                    flag <= 0;
                    err <= 1;
                end
                else begin
                    disc <= 0;
                    flag <= 0;
                    err <= 0;
                end
            end
        endcase
    end
end

always @(*) begin
    case (state)
        IDLE: begin
            if (in) begin
                next_state = ONE;
            end
            else begin
                next_state = IDLE;
            end
        end
        ONE: begin
            if (in) begin
                next_state = TWO;
            end
            else begin
                next_state = IDLE;
            end
        end
        TWO: begin
            if (in) begin
                next_state = THREE;
            end
            else begin
                next_state = IDLE;
            end
        end
        THREE: begin
            if (in) begin
                next_state = FOUR;
            end
            else begin
                next_state = IDLE;
            end
        end
        FOUR: begin
            if (in) begin
                next_state = FIVE;
            end
            else begin
                next_state = IDLE;
            end
        end
        FIVE: begin
            if (in) begin
                next_state = SIX;
            end
            else begin
                next_state = IDLE;
            end
        end
        SIX: begin
            if (in) begin
                next_state = SEVEN;
            end
            else begin
                next_state = IDLE;
            end
        end
        SEVEN: begin
            if (in) begin
                next_state = SEVEN;
            end
            else begin
                next_state = IDLE;
            end
        end
    endcase
end

endmodule
