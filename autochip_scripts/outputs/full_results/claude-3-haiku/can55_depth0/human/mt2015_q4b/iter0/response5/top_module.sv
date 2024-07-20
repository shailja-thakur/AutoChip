module top_module(
    input x,
    input y,
    output reg z
);

reg [1:0] state;
parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b11;

always @(posedge x, posedge y) begin
    case (state)
        S0: begin
            if (x && !y)
                state <= S1;
            else
                z <= 1'b1;
        end
        S1: begin
            if (!x && y)
                state <= S2;
            else
                z <= 1'b0;
        end
        S2: begin
            if (x && y)
                state <= S0;
            else
                z <= 1'b0;
        end
        default: state <= S0;
    endcase
end

endmodule
