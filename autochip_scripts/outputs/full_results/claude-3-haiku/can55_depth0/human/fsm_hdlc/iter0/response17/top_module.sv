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
    FIVE_ONES = 3'b001,
    SIX_ONES = 3'b010,
    SEVEN_ONES = 3'b011;

reg [2:0] state, next_state;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
    end else begin
        state <= next_state;
    end
end

always @(*) begin
    disc = 1'b0;
    flag = 1'b0;
    err = 1'b0;
    next_state = state;
    case (state)
        IDLE: begin
            if (in == 1'b1) begin
                next_state = FIVE_ONES;
            end else begin
                next_state = IDLE;
            end
        end
        FIVE_ONES: begin
            if (in == 1'b1) begin
                next_state = SIX_ONES;
                disc = 1'b1;
            end else begin
                next_state = IDLE;
            end
        end
        SIX_ONES: begin
            if (in == 1'b1) begin
                next_state = SEVEN_ONES;
                flag = 1'b1;
            end else begin
                next_state = IDLE;
            end
        end
        SEVEN_ONES: begin
            if (in == 1'b1) begin
                next_state = SEVEN_ONES;
                err = 1'b1;
            end else begin
                next_state = IDLE;
            end
        end
        default: begin
            next_state = IDLE;
        end
    endcase
end

endmodule
