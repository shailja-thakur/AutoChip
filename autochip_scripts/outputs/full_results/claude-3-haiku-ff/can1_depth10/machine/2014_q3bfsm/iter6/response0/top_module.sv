module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

reg [2:0] state;
parameter A = 3'b000, B = 3'b001, C = 3'b010, D = 3'b011, E = 3'b100;

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
                else state <= D;
            end
            E: begin
                if (x) state <= E;
                else state <= D;
            end
            default: state <= A;
        endcase
    end
end

always @(*) begin
    case (state)
        D, E: z = 1'b1;
        default: z = 1'b0;
    endcase
end

endmodule
