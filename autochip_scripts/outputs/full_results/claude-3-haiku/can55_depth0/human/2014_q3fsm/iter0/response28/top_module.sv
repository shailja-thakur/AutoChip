module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

reg [1:0] state;
parameter A = 2'd0, B = 2'd1, C = 2'd2;

always @(posedge clk) begin
    if (reset) begin
        state <= A;
        z <= 1'b0;
    end
    else begin
        case (state)
            A: begin
                if (s) begin
                    state <= B;
                end
                else begin
                    state <= A;
                end
            end
            B: begin
                if (w) begin
                    state <= C;
                end
                else begin
                    state <= B;
                end
            end
            C: begin
                if (w) begin
                    state <= B;
                    z <= 1'b1;
                end
                else begin
                    state <= B;
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
