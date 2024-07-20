module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

reg [1:0] state;
parameter A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11;

always @(posedge clk, posedge reset) begin
    if (reset) begin
        state <= A;
        out <= 0;
    end
    else begin
        case (state)
            A: begin
                out <= 0;
                if (in) state <= B;
                else state <= A;
            end
            B: begin
                out <= 0;
                if (in) state <= B;
                else state <= C;
            end
            C: begin
                out <= 0;
                if (in) state <= D;
                else state <= A;
            end
            D: begin
                out <= 1;
                if (in) state <= B;
                else state <= C;
            end
        endcase
    end
end

endmodule
