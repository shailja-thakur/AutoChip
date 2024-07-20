module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

localparam STATE_ZERO = 3'b000;
localparam STATE_ONE = 3'b001;
localparam STATE_TWO = 3'b010;
localparam STATE_THREE = 3'b011;
localparam STATE_FOUR = 3'b100;
localparam STATE_FIVE = 3'b101;
localparam STATE_SIX = 3'b110;

reg [2:0] state, next_state;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= STATE_ZERO;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        STATE_ZERO: begin
            disc = 1'b0;
            flag = 1'b0;
            err = 1'b0;
            if (in == 1'b1) begin
                next_state = STATE_ONE;
            end
            else begin
                next_state = STATE_ZERO;
            end
        end
        STATE_ONE: begin
            disc = 1'b0;
            flag = 1'b0;
            err = 1'b0;
            if (in == 1'b1) begin
                next_state = STATE_TWO;
            end
            else begin
                next_state = STATE_ZERO;
            end
        end
        STATE_TWO: begin
            disc = 1'b0;
            flag = 1'b0;
            err = 1'b0;
            if (in == 1'b1) begin
                next_state = STATE_THREE;
            end
            else begin
                next_state = STATE_ZERO;
            end
        end
        STATE_THREE: begin
            disc = 1'b0;
            flag = 1'b0;
            err = 1'b0;
            if (in == 1'b1) begin
                next_state = STATE_FOUR;
            end
            else begin
                next_state = STATE_ZERO;
            end
        end
        STATE_FOUR: begin
            disc = 1'b0;
            flag = 1'b0;
            err = 1'b0;
            if (in == 1'b1) begin
                next_state = STATE_FIVE;
            end
            else begin
                next_state = STATE_ZERO;
            end
        end
        STATE_FIVE: begin
            disc = 1'b1;
            flag = 1'b0;
            err = 1'b0;
            if (in == 1'b1) begin
                next_state = STATE_SIX;
            end
            else begin
                next_state = STATE_ZERO;
            end
        end
        STATE_SIX: begin
            disc = 1'b0;
            flag = 1'b1;
            err = 1'b0;
            if (in == 1'b1) begin
                next_state = STATE_SIX;
            end
            else begin
                next_state = STATE_ZERO;
            end
        end
        default: begin
            disc = 1'b0;
            flag = 1'b0;
            err = 1'b1;
            next_state = STATE_ZERO;
        end
    endcase
end

endmodule
