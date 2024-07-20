module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

reg [1:0] state;
reg [1:0] count;

localparam A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11;

always @(posedge clk) begin
    if (reset) begin
        state <= A;
        count <= 0;
        z <= 0;
    end
    else begin
        case (state)
            A: begin
                if (s) state <= B;
                else state <= A;
            end
            B: begin
                state <= C;
                count <= 1;
            end
            C: begin
                if (w) count <= count + 1;
                else count <= count;
                if (count == 2) state <= D;
                else state <= C;
            end
            D: begin
                z <= 1;
                state <= B;
                count <= 0;
            end
        endcase
    end
end

endmodule
