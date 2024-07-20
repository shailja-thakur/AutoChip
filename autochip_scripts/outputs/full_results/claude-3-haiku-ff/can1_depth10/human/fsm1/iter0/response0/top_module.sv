module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

reg state;
parameter A = 1'b0, B = 1'b1;

always @(posedge clk or posedge areset) begin
    if (areset)
        state <= B;
    else begin
        case (state)
            B: begin
                if (in == 0)
                    state <= A;
                else
                    state <= B;
            end
            A: begin
                if (in == 0)
                    state <= B;
                else
                    state <= A;
            end
        endcase
    end
end

always @(*) begin
    case (state)
        A: out = 0;
        B: out = 1;
    endcase
end

endmodule
