module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

localparam [2:0] IDLE = 3'b000,
                 ONE  = 3'b001,
                 TWO  = 3'b010,
                 THREE = 3'b011,
                 FOUR = 3'b100,
                 FIVE = 3'b101,
                 SIX = 3'b110;

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
    case (state)
        IDLE: begin
            disc = 0;
            flag = 0;
            err = 0;
            if (in == 0) begin
                next_state = IDLE;
            end
            else begin
                next_state = ONE;
            end
        end
        ONE: begin
            disc = 0;
            flag = 0;
            err = 0;
            if (in == 0) begin
                next_state = IDLE;
            end
            else begin
                next_state = TWO;
            end
        end
        TWO: begin
            disc = 0;
            flag = 0;
            err = 0;
            if (in == 0) begin
                next_state = IDLE;
            end
            else begin
                next_state = THREE;
            end
        end
        THREE: begin
            disc = 0;
            flag = 0;
            err = 0;
            if (in == 0) begin
                next_state = IDLE;
            end
            else begin
                next_state = FOUR;
            end
        end
        FOUR: begin
            disc = 0;
            flag = 0;
            err = 0;
            if (in == 0) begin
                next_state = IDLE;
            end
            else begin
                next_state = FIVE;
            end
        end
        FIVE: begin
            disc = 1;
            flag = 0;
            err = 0;
            if (in == 0) begin
                next_state = IDLE;
            end
            else begin
                next_state = SIX;
            end
        end
        SIX: begin
            disc = 0;
            flag = 1;
            err = 0;
            if (in == 0) begin
                next_state = IDLE;
            end
            else begin
                next_state = ONE;
            end
        end
        default: begin
            disc = 0;
            flag = 0;
            err = 1;
            next_state = IDLE;
        end
    endcase
end

endmodule
