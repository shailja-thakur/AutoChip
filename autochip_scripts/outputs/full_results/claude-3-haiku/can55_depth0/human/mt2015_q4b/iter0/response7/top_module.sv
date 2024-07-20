module top_module(
    input x,
    input y,
    output reg z
);

reg [1:0] state;
parameter INIT = 2'b00, X_HIGH = 2'b01, Y_HIGH = 2'b10, XY_HIGH = 2'b11;

always @(posedge x, posedge y) begin
    case (state)
        INIT: begin
            if (x)
                state <= X_HIGH;
            else if (y)
                state <= Y_HIGH;
            else
                state <= INIT;
        end
        X_HIGH: begin
            if (y)
                state <= XY_HIGH;
            else
                state <= X_HIGH;
        end
        Y_HIGH: begin
            if (x)
                state <= XY_HIGH;
            else
                state <= Y_HIGH;
        end
        XY_HIGH: begin
            if (~x & ~y)
                state <= INIT;
            else
                state <= XY_HIGH;
        end
    endcase

    case (state)
        INIT: z <= 1'b1;
        X_HIGH: z <= 1'b0;
        Y_HIGH: z <= 1'b0;
        XY_HIGH: z <= 1'b1;
    endcase
end

endmodule
