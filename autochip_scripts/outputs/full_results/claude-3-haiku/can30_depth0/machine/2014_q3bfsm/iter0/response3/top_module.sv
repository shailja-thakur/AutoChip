module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

reg [2:0] state;
localparam [2:0] 
    A = 3'b000,
    B = 3'b001,
    C = 3'b010,
    D = 3'b011,
    E = 3'b100;

always @(posedge clk) begin
    if (reset) begin
        state <= A;
    end
    else begin
        case (state)
            A: begin
                if (x) begin
                    state <= B;
                end
                else begin
                    state <= A;
                end
            end
            B: begin
                if (x) begin
                    state <= E;
                end
                else begin
                    state <= B;
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
            D: begin
                if (x) begin
                    state <= C;
                end
                else begin
                    state <= B;
                end
            end
            E: begin
                if (x) begin
                    state <= E;
                end
                else begin
                    state <= D;
                end
            end
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
