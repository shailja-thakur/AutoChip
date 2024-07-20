module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

parameter A = 1'b0;
parameter B = 1'b1;

reg state;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= A;
        z <= 1'b0;
    end
    else begin
        case (state)
            A: begin
                if (x) begin
                    state <= B;
                    z <= 1'b1;
                end
                else begin
                    state <= A;
                    z <= 1'b0;
                end
            end
            B: begin
                if (~x) begin
                    state <= B;
                    z <= 1'b1;
                end
                else begin
                    state <= A;
                    z <= 1'b0;
                end
            end
            default: begin
                state <= A;
                z <= 1'b0;
            end
        endcase
    end
end

endmodule
