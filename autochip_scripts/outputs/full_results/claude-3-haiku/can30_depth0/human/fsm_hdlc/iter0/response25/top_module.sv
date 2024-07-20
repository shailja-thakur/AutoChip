module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

localparam [2:0] 
    IDLE = 3'b000,
    CHECK_1 = 3'b001,
    CHECK_2 = 3'b010,
    CHECK_3 = 3'b011,
    CHECK_4 = 3'b100,
    CHECK_5 = 3'b101,
    CHECK_6 = 3'b110,
    CHECK_7 = 3'b111;

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
            CHECK_1: begin
                if (in) begin
                    next_state <= CHECK_2;
                end
                else begin
                    next_state <= IDLE;
                end
            end
            CHECK_2: begin
                if (in) begin
                    next_state <= CHECK_3;
                end
                else begin
                    next_state <= IDLE;
                end
            end
            CHECK_3: begin
                if (in) begin
                    next_state <= CHECK_4;
                end
                else begin
                    next_state <= IDLE;
                end
            end
            CHECK_4: begin
                if (in) begin
                    next_state <= CHECK_5;
                end
                else begin
                    next_state <= IDLE;
                end
            end
            CHECK_5: begin
                if (in) begin
                    next_state <= CHECK_6;
                    disc <= 1;
                end
                else begin
                    next_state <= IDLE;
                end
            end
            CHECK_6: begin
                if (in) begin
                    next_state <= CHECK_7;
                    flag <= 1;
                end
                else begin
                    next_state <= IDLE;
                end
            end
            CHECK_7: begin
                if (in) begin
                    err <= 1;
                end
                else begin
                    next_state <= IDLE;
                end
            end
            default: begin
                next_state <= IDLE;
            end
        endcase
    end
end

endmodule
