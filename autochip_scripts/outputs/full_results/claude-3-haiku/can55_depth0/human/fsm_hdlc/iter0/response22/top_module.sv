module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

parameter IDLE = 2'b00, SEEN1 = 2'b01, SEEN5 = 2'b10, ERROR = 2'b11;
reg [1:0] state, next_state;

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
            SEEN1: begin
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
            SEEN5: begin
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
            ERROR: begin
                disc <= 0;
                flag <= 0;
                err <= 1;
            end
        endcase
    end
end

always @(*) begin
    case (state)
        IDLE: begin
            if (in) next_state = SEEN1;
            else next_state = IDLE;
        end
        SEEN1: begin
            if (in) next_state = SEEN5;
            else next_state = IDLE;
        end
        SEEN5: begin
            if (in) next_state = ERROR;
            else next_state = IDLE;
        end
        ERROR: begin
            next_state = ERROR;
        end
    endcase
end

endmodule
