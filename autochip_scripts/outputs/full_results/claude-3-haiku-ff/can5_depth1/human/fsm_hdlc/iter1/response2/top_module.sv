module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

localparam [2:0] 
    S_IDLE = 3'b000,
    S_1_1 = 3'b001,
    S_2_1 = 3'b010,
    S_3_1 = 3'b011,
    S_4_1 = 3'b100,
    S_5_1 = 3'b101,
    S_6_1 = 3'b110,
    S_7_1 = 3'b111;

reg [2:0] state, next_state;

always @(posedge clk) begin
    if (reset) begin
        state <= S_IDLE;
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
        S_IDLE: begin
            if (in == 1'b1) begin
                next_state = S_1_1;
            end
        end
        S_1_1: begin
            if (in == 1'b1) begin
                next_state = S_2_1;
            end else begin
                next_state = S_IDLE;
            end
        end
        S_2_1: begin
            if (in == 1'b1) begin
                next_state = S_3_1;
            end else begin
                next_state = S_IDLE;
            end
        end
        S_3_1: begin
            if (in == 1'b1) begin
                next_state = S_4_1;
            end else begin
                next_state = S_IDLE;
            end
        end
        S_4_1: begin
            if (in == 1'b1) begin
                next_state = S_5_1;
            end else begin
                next_state = S_IDLE;
            end
        end
        S_5_1: begin
            if (in == 1'b1) begin
                next_state = S_6_1;
                disc = 1'b1;
            end else begin
                next_state = S_IDLE;
            end
        end
        S_6_1: begin
            if (in == 1'b1) begin
                next_state = S_7_1;
                flag = 1'b1;
            end else begin
                next_state = S_IDLE;
            end
        end
        S_7_1: begin
            if (in == 1'b1) begin
                err = 1'b1;
                next_state = S_IDLE;
            end else begin
                next_state = S_IDLE;
            end
        end
    endcase
end

endmodule
