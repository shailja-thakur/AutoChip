module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

parameter [2:0] IDLE = 3'b000,
                DETECT_FIVE = 3'b001,
                DETECT_SIX = 3'b010,
                DETECT_SEVEN = 3'b011;

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
                next_state = DETECT_FIVE;
            end
            else begin
                next_state = IDLE;
            end
        end
        DETECT_FIVE: begin
            if (in == 1'b1) begin
                next_state = DETECT_SIX;
            end
            else begin
                next_state = IDLE;
            end
        end
        DETECT_SIX: begin
            if (in == 1'b1) begin
                next_state = DETECT_SEVEN;
                flag = 1'b1;
            end
            else begin
                next_state = IDLE;
                disc = 1'b1;
            end
        end
        DETECT_SEVEN: begin
            if (in == 1'b1) begin
                next_state = DETECT_SEVEN;
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
