module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

reg [2:0] state;
parameter [2:0] IDLE = 3'b000,
                ONES_1 = 3'b001,
                ONES_2 = 3'b010,
                ONES_3 = 3'b011,
                ONES_4 = 3'b100,
                ONES_5 = 3'b101,
                ONES_6 = 3'b110,
                ONES_7 = 3'b111;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        disc <= 0;
        flag <= 0;
        err <= 0;
    end
    else begin
        case (state)
            IDLE: begin
                if (in) begin
                    state <= ONES_1;
                end
                else begin
                    state <= IDLE;
                end
                disc <= 0;
                flag <= 0;
                err <= 0;
            end
            ONES_1: begin
                if (in) begin
                    state <= ONES_2;
                end
                else begin
                    state <= IDLE;
                end
                disc <= 0;
                flag <= 0;
                err <= 0;
            end
            ONES_2: begin
                if (in) begin
                    state <= ONES_3;
                end
                else begin
                    state <= IDLE;
                end
                disc <= 0;
                flag <= 0;
                err <= 0;
            end
            ONES_3: begin
                if (in) begin
                    state <= ONES_4;
                end
                else begin
                    state <= IDLE;
                end
                disc <= 0;
                flag <= 0;
                err <= 0;
            end
            ONES_4: begin
                if (in) begin
                    state <= ONES_5;
                end
                else begin
                    state <= IDLE;
                end
                disc <= 0;
                flag <= 0;
                err <= 0;
            end
            ONES_5: begin
                if (in) begin
                    state <= ONES_6;
                end
                else begin
                    state <= IDLE;
                end
                disc <= 1;
                flag <= 0;
                err <= 0;
            end
            ONES_6: begin
                if (in) begin
                    state <= ONES_7;
                end
                else begin
                    state <= IDLE;
                end
                disc <= 0;
                flag <= 1;
                err <= 0;
            end
            ONES_7: begin
                if (in) begin
                    state <= ONES_7;
                end
                else begin
                    state <= IDLE;
                end
                disc <= 0;
                flag <= 0;
                err <= 1;
            end
        endcase
    end
end

endmodule
