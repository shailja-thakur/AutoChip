module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

// Define the states of the FSM
parameter [2:0] IDLE = 3'b000, // 0 consecutive 1s
                ONE = 3'b001, // 1 consecutive 1
                TWO = 3'b010, // 2 consecutive 1s
                THREE = 3'b011, // 3 consecutive 1s
                FOUR = 3'b100, // 4 consecutive 1s
                FIVE = 3'b101, // 5 consecutive 1s
                SIX = 3'b110, // 6 consecutive 1s
                SEVEN = 3'b111; // 7 or more consecutive 1s

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
            ONE: begin
                disc <= 0;
                flag <= 0;
                err <= 0;
            end
            TWO: begin
                disc <= 0;
                flag <= 0;
                err <= 0;
            end
            THREE: begin
                disc <= 0;
                flag <= 0;
                err <= 0;
            end
            FOUR: begin
                disc <= 0;
                flag <= 0;
                err <= 0;
            end
            FIVE: begin
                disc <= 0;
                flag <= 0;
                err <= 0;
            end
            SIX: begin
                disc <= 0;
                flag <= 1;
                err <= 0;
            end
            SEVEN: begin
                disc <= 0;
                flag <= 0;
                err <= 1;
            end
        endcase
    end
end

// Next state logic
always @(*) begin
    case (state)
        IDLE: begin
            if (in == 1'b1) next_state = ONE;
            else next_state = IDLE;
        end
        ONE: begin
            if (in == 1'b1) next_state = TWO;
            else next_state = IDLE;
        end
        TWO: begin
            if (in == 1'b1) next_state = THREE;
            else next_state = IDLE;
        end
        THREE: begin
            if (in == 1'b1) next_state = FOUR;
            else next_state = IDLE;
        end
        FOUR: begin
            if (in == 1'b1) next_state = FIVE;
            else next_state = IDLE;
        end
        FIVE: begin
            if (in == 1'b1) next_state = SIX;
            else next_state = IDLE;
        end
        SIX: begin
            if (in == 1'b1) next_state = SEVEN;
            else next_state = IDLE;
        end
        SEVEN: begin
            if (in == 1'b1) next_state = SEVEN;
            else next_state = IDLE;
        end
    endcase
end

endmodule
