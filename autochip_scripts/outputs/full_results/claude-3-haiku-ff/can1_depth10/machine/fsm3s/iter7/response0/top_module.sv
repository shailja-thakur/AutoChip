module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

reg [1:0] state;
parameter A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= A;
        out <= 1'b0;
    end
    else begin
        case (state)
            A: begin
                if (in) begin
                    state <= B;
                end
                else begin
                    state <= A;
                end
                out <= 1'b0;
            end
            B: begin
                if (in) begin
                    state <= B;
                end
                else begin
                    state <= C;
                end
                out <= 1'b0;
            end
            C: begin
                if (in) begin
                    state <= D;
                end
                else begin
                    state <= A;
                end
                out <= 1'b0;
            end
            D: begin
                if (in) begin
                    state <= B;
                end
                else begin
                    state <= C;
                end
                out <= 1'b1;
            end
        endcase
    end
end

endmodule
