module top_module(
    input x,
    input y,
    output reg z);

reg [1:0] state;

always @(x, y)
begin
    case (state)
        0: begin
            if (x == 1 && y == 0)
                state <= 1;
            else
                state <= 0;
        end
        1: begin
            if (x == 0 && y == 1)
                state <= 2;
            else
                state <= 1;
        end
        2: begin
            if (x == 1 && y == 1)
                state <= 3;
            else
                state <= 2;
        end
        3: begin
            if (x == 0 && y == 0)
                state <= 0;
            else
                state <= 3;
        end
    endcase
end

always @(state)
begin
    case (state)
        0: z <= 1;
        1: z <= 0;
        2: z <= 1;
        3: z <= 0;
    endcase
end

endmodule
