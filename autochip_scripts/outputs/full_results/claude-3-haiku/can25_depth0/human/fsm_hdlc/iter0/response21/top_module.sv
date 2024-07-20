module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

    parameter [2:0] IDLE = 3'b000,
                    ONEFLAG = 3'b001,
                    TWOFLAG = 3'b010,
                    THREEFLAG = 3'b011,
                    FOURFLAG = 3'b100,
                    FIVEFLAG = 3'b101,
                    ERROR = 3'b110;

    reg [2:0] state, next_state;

    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
        end
        else begin
            state <= next_state;
        end
    end

    always @(*) begin
        disc = 1'b0;
        flag = 1'b0;
        err = 1'b0;

        case (state)
            IDLE: begin
                if (in == 1'b1) begin
                    next_state = ONEFLAG;
                end
                else begin
                    next_state = IDLE;
                end
            end
            ONEFLAG: begin
                if (in == 1'b1) begin
                    next_state = TWOFLAG;
                end
                else begin
                    next_state = IDLE;
                end
            end
            TWOFLAG: begin
                if (in == 1'b1) begin
                    next_state = THREEFLAG;
                end
                else begin
                    next_state = IDLE;
                end
            end
            THREEFLAG: begin
                if (in == 1'b1) begin
                    next_state = FOURFLAG;
                end
                else begin
                    next_state = IDLE;
                end
            end
            FOURFLAG: begin
                if (in == 1'b1) begin
                    next_state = FIVEFLAG;
                end
                else begin
                    next_state = IDLE;
                end
            end
            FIVEFLAG: begin
                if (in == 1'b1) begin
                    next_state = ERROR;
                    err = 1'b1;
                end
                else begin
                    next_state = IDLE;
                    disc = 1'b1;
                end
            end
            ERROR: begin
                if (in == 1'b1) begin
                    next_state = ERROR;
                    err = 1'b1;
                end
                else begin
                    next_state = IDLE;
                end
            end
            default: begin
                next_state = IDLE;
            end
        endcase

        if (state == FOURFLAG && in == 1'b0) begin
            next_state = IDLE;
            flag = 1'b1;
        end
    end

endmodule
