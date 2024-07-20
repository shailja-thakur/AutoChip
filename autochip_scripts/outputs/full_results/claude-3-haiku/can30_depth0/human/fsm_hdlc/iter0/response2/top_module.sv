module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

localparam [2:0] IDLE = 3'd0,
                 ONES_1 = 3'd1,
                 ONES_2 = 3'd2, 
                 ONES_3 = 3'd3,
                 ONES_4 = 3'd4,
                 ONES_5 = 3'd5,
                 ONES_6 = 3'd6;

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
    next_state = state;
    disc = 1'b0;
    flag = 1'b0;
    err = 1'b0;

    case (state)
        IDLE: begin
            if (in == 1'b1) begin
                next_state = ONES_1;
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
            if (in == 1'b0) begin
                next_state = IDLE;
                flag = 1'b1;
            end
            else begin
                next_state = ONES_6;
                err = 1'b1;
            end
        end
        default: begin
            next_state = IDLE;
        end
    endcase
end

endmodule
