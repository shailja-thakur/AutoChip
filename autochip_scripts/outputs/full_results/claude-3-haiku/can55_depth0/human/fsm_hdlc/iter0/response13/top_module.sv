module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

reg [2:0] state;
parameter ZERO = 3'b000, ONE = 3'b001, TWO = 3'b010, THREE = 3'b011, FOUR = 3'b100, FIVE = 3'b101, SIX = 3'b110, ERROR = 3'b111;

always @(posedge clk) begin
    if (reset) begin
        state <= ZERO;
        disc <= 0;
        flag <= 0;
        err <= 0;
    end
    else begin
        case (state)
            ZERO: begin
                if (in == 0) state <= ZERO;
                else if (in == 1) state <= ONE;
                disc <= 0;
                flag <= 0;
                err <= 0;
            end
            ONE: begin
                if (in == 0) state <= ZERO;
                else if (in == 1) state <= TWO;
                disc <= 0;
                flag <= 0;
                err <= 0;
            end
            TWO: begin
                if (in == 0) state <= ZERO;
                else if (in == 1) state <= THREE;
                disc <= 0;
                flag <= 0;
                err <= 0;
            end
            THREE: begin
                if (in == 0) state <= ZERO;
                else if (in == 1) state <= FOUR;
                disc <= 0;
                flag <= 0;
                err <= 0;
            end
            FOUR: begin
                if (in == 0) state <= ZERO;
                else if (in == 1) state <= FIVE;
                disc <= 0;
                flag <= 0;
                err <= 0;
            end
            FIVE: begin
                if (in == 0) state <= ZERO;
                else if (in == 1) state <= SIX;
                disc <= 1;
                flag <= 0;
                err <= 0;
            end
            SIX: begin
                if (in == 0) state <= ZERO;
                else if (in == 1) state <= ERROR;
                disc <= 0;
                flag <= 1;
                err <= 0;
            end
            ERROR: begin
                if (in == 0) state <= ZERO;
                else if (in == 1) state <= ERROR;
                disc <= 0;
                flag <= 0;
                err <= 1;
            end
        endcase
    end
end

endmodule
