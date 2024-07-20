module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

reg [2:0] state;
localparam A = 3'b000, B = 3'b001, C = 3'b010, D = 3'b011, E = 3'b100;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= A;
    end
    else begin
        case (state)
            A: begin
                if (x) state <= B;
                else state <= A;
            end
            B: begin
                if (x) state <= E;
                else state <= B;
            end
            C: begin
                if (x) state <= B;
                else state <= C;
            end
            D: begin
                if (x) state <= C;
                else state <= B;
            end
            E: begin
                if (x) state <= E;
                else state <= D;
            end
        endcase
    end
end

always @(*) begin
    z = (state == D) | (state == E);
end

endmodule
