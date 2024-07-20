module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

reg [1:0] state;
parameter A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11;

always @(posedge clk) begin
    if (reset) begin
        state <= A;
        z <= 0;
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
                z <= 0;
            end
            B: begin
                if (w) begin
                    state <= C;
                end
                else begin
                    state <= B;
                end
                z <= 0;
            end
            C: begin
                if (w) begin
                    state <= D;
                end
                else begin
                    state <= B;
                end
                z <= 0;
            end
            D: begin
                if (w) begin
                    state <= B;
                end
                else begin
                    state <= B;
                end
                z <= 1;
            end
        endcase
    end
end

endmodule
