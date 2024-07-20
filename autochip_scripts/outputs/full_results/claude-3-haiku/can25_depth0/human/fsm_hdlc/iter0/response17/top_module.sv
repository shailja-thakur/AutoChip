module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

localparam [2:0] IDLE = 3'b000,
                 ONES_1 = 3'b001,
                 ONES_2 = 3'b010,
                 ONES_3 = 3'b011,
                 ONES_4 = 3'b100,
                 ONES_5 = 3'b101,
                 ONES_6 = 3'b110,
                 ONES_7 = 3'b111;

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
                next_state = ONES_1;
            end
            else begin
                next_state = IDLE;
            end
        end
        ONES_1: begin
            if (in == 1'b1) begin
                next_state = ONES_2;
            end
            else begin
                next_state = IDLE;
            end
        end
        ONES_2: begin
            if (in == 1'b1) begin
                next_state = ONES_3;
            end
            else begin
                next_state = IDLE;
            end
        end
        ONES_3: begin
            if (in == 1'b1) begin
                next_state = ONES_4;
            end
            else begin
                next_state = IDLE;
            end
        end
        ONES_4: begin
            if (in == 1'b1) begin
                next_state = ONES_5;
            end
            else begin
                next_state = IDLE;
            end
        end
        ONES_5: begin
            if (in == 1'b1) begin
                next_state = ONES_6;
                disc = 1'b1;
            end
            else begin
                next_state = IDLE;
            end
        end
        ONES_6: begin
            if (in == 1'b1) begin
                next_state = ONES_7;
                flag = 1'b1;
            end
            else begin
                next_state = IDLE;
            end
        end
        ONES_7: begin
            if (in == 1'b1) begin
                next_state = ONES_7;
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
end

endmodule
