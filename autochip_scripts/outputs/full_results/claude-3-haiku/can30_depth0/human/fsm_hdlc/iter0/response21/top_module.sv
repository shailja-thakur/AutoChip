module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

parameter IDLE = 3'b000, ONE = 3'b001, TWO = 3'b010, THREE = 3'b011, FOUR = 3'b100, FIVE = 3'b101, SIX = 3'b110;
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
            if (in == 1'b0) begin
                next_state = ONE;
            end
            else begin
                next_state = IDLE;
            end
        end
        ONE: begin
            if (in == 1'b1) begin
                next_state = TWO;
            end
            else begin
                next_state = IDLE;
            end
        end
        TWO: begin
            if (in == 1'b1) begin
                next_state = THREE;
            end
            else begin
                next_state = IDLE;
            end
        end
        THREE: begin
            if (in == 1'b1) begin
                next_state = FOUR;
            end
            else begin
                next_state = IDLE;
            end
        end
        FOUR: begin
            if (in == 1'b1) begin
                next_state = FIVE;
            end
            else begin
                next_state = IDLE;
            end
        end
        FIVE: begin
            if (in == 1'b1) begin
                next_state = SIX;
            end
            else begin
                next_state = IDLE;
            end
        end
        SIX: begin
            if (in == 1'b0) begin
                disc = 1'b1;
                next_state = IDLE;
            end
            else if (in == 1'b1) begin
                flag = 1'b1;
                next_state = IDLE;
            end
            else begin
                err = 1'b1;
                next_state = IDLE;
            end
        end
    endcase
end

endmodule
