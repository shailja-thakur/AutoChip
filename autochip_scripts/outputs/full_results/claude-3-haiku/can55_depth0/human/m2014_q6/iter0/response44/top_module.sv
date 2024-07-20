module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

// Declare state registers
reg [2:0] state;
parameter A = 3'b000, B = 3'b001, C = 3'b010, D = 3'b011, E = 3'b100, F = 3'b101;

always @(posedge clk, posedge reset) begin
    if (reset) begin
        state <= A;
        z <= 0;
    end
    else begin
        case (state)
            A: begin
                if (w) begin
                    state <= A;
                end
                else begin
                    state <= B;
                end
                z <= 0;
            end
            B: begin
                if (w) begin
                    state <= D;
                end
                else begin
                    state <= C;
                end
                z <= 0;
            end
            C: begin
                if (w) begin
                    state <= D;
                end
                else begin
                    state <= E;
                end
                z <= 0;
            end
            D: begin
                if (w) begin
                    state <= A;
                end
                else begin
                    state <= F;
                end
                z <= 0;
            end
            E: begin
                if (w) begin
                    state <= D;
                end
                else begin
                    state <= E;
                end
                z <= 1;
            end
            F: begin
                if (w) begin
                    state <= D;
                end
                else begin
                    state <= C;
                end
                z <= 1;
            end
            default: begin
                state <= A;
                z <= 0;
            end
        endcase
    end
end

endmodule
