module top_module (
    input clk,
    input areset,
    input x,
    output z
);

parameter A = 2'd0;
parameter B = 2'd1;
parameter C = 2'd2;

reg [1:0] state;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= A;
    end
    else begin
        case (state)
            A: begin
                if (x) begin
                    state <= C;
                end
                else begin
                    state <= A;
                end
            end
            B: begin
                if (x) begin
                    state <= B;
                end
                else begin
                    state <= C;
                end
            end
            C: begin
                if (x) begin
                    state <= B;
                end
                else begin
                    state <= C;
                end
            end
            default: begin
                state <= A;
            end
        endcase
    end
end

assign z = (state == C);

endmodule
