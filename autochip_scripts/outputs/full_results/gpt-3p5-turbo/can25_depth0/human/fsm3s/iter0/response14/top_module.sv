module top_module (
    input clk,
    input in,
    input reset,
    output out
);

reg [1:0] state, next_state;
reg out_reg;

parameter A=2'b00, B=2'b01, C=2'b10, D=2'b11;

always @(posedge clk or posedge reset) begin
    if (reset)
        state <= A;
    else
        state <= next_state;
end

always @(state, in) begin
    case (state)
        A: begin
            if (in)
                next_state <= B;
            else
                next_state <= A;
            out_reg <= 0;
        end

        B: begin
            if (in)
                next_state <= B;
            else
                next_state <= C;
            out_reg <= 0;
        end

        C: begin
            if (in)
                next_state <= D;
            else
                next_state <= A;
            out_reg <= 0;
        end

        D: begin
            if (in)
                next_state <= B;
            else
                next_state <= C;
            out_reg <= 1;
        end
    endcase
end

assign out = out_reg;

endmodule
