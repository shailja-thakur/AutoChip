module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

reg [1:0] state;
parameter A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11;

always @(posedge clk, posedge reset) begin
    if (reset)
        state <= A;
    else begin
        case(state)
            A: begin
                if (in)
                    state <= B;
                else
                    state <= A;
            end
            B: begin
                if (in)
                    state <= B;
                else
                    state <= C;
            end
            C: begin
                if (in)
                    state <= D;
                else
                    state <= A;
            end
            D: begin
                if (in)
                    state <= B;
                else
                    state <= C;
            end
        endcase
    end
end

always @* begin
    case(state)
        D: out = 1'b1;
        default: out = 1'b0;
    endcase
end

endmodule
