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
                if (s) state <= B;
                else state <= A;
            end
            B: begin
                if (w) begin
                    if (state == B) state <= C;
                    else state <= B;
                end
                else state <= B;
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
            default: state <= A;
        endcase
    end
end

endmodule
