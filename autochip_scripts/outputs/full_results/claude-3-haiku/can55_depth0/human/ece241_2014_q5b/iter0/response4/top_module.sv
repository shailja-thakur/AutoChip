module top_module (
    input clk,
    input areset,
    input x,
    output z
);

reg [1:0] state;
parameter A = 2'b01, B = 2'b10;

always @(posedge clk, posedge areset) begin
    if (areset)
        state <= A;
    else begin
        case (state)
            A: begin
                if (x)
                    state <= B;
                else
                    state <= A;
            end
            B: begin
                if (x)
                    state <= B;
                else
                    state <= B;
            end
            default:
                state <= A;
        endcase
    end
end

assign z = (state == B) & ~x;

endmodule
