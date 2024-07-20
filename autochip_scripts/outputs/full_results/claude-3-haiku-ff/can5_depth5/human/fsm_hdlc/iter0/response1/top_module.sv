module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

localparam [2:0] IDLE = 3'b000,
                 SINGLE_ONE = 3'b001,
                 TWO_ONE = 3'b010,
                 THREE_ONE = 3'b011,
                 FOUR_ONE = 3'b100,
                 FIVE_ONE = 3'b101,
                 SIX_ONE = 3'b110,
                 SEVEN_ONE = 3'b111;

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
            SINGLE_ONE: begin
                disc <= 0;
                flag <= 0;
                err <= 0;
            end
            TWO_ONE: begin
                disc <= 0;
                flag <= 0;
                err <= 0;
            end
            THREE_ONE: begin
                disc <= 0;
                flag <= 0;
                err <= 0;
            end
            FOUR_ONE: begin
                disc <= 0;
                flag <= 0;
                err <= 0;
            end
            FIVE_ONE: begin
                disc <= 0;
                flag <= 0;
                err <= 0;
            end
            SIX_ONE: begin
                disc <= 1;
                flag <= 1;
                err <= 0;
            end
            SEVEN_ONE: begin
                disc <= 0;
                flag <= 0;
                err <= 1;
            end
        endcase
    end
end

always @(*) begin
    case (state)
        IDLE: begin
            if (in == 1'b0) next_state = SINGLE_ONE;
            else next_state = IDLE;
        end
        SINGLE_ONE: begin
            if (in == 1'b0) next_state = IDLE;
            else if (in == 1'b1) next_state = TWO_ONE;
        end
        TWO_ONE: begin
            if (in == 1'b0) next_state = SINGLE_ONE;
            else if (in == 1'b1) next_state = THREE_ONE;
        end
        THREE_ONE: begin
            if (in == 1'b0) next_state = TWO_ONE;
            else if (in == 1'b1) next_state = FOUR_ONE;
        end
        FOUR_ONE: begin
            if (in == 1'b0) next_state = THREE_ONE;
            else if (in == 1'b1) next_state = FIVE_ONE;
        end
        FIVE_ONE: begin
            if (in == 1'b0) next_state = FOUR_ONE;
            else if (in == 1'b1) next_state = SIX_ONE;
        end
        SIX_ONE: begin
            if (in == 1'b0) next_state = IDLE;
            else if (in == 1'b1) next_state = SEVEN_ONE;
        end
        SEVEN_ONE: begin
            if (in == 1'b0) next_state = IDLE;
            else if (in == 1'b1) next_state = SEVEN_ONE;
        end
    endcase
end

endmodule
