module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

// State register
reg [3:0] state;
parameter A = 4'b0000, B = 4'b0001, C = 4'b0010, D = 4'b0011,
          E = 4'b0100, F = 4'b0101;

always @(posedge clk, posedge reset) begin
    if (reset) begin
        state <= A;
        z <= 0;
    end
    else begin
        case (state)
            A: begin
                if (w == 0)
                    state <= B;
                else
                    state <= A;
                z <= 0;
            end
            B: begin
                if (w == 0)
                    state <= C;
                else
                    state <= D;
                z <= 0;
            end
            C: begin
                if (w == 0)
                    state <= E;
                else
                    state <= D;
                z <= 0;
            end
            D: begin
                if (w == 0)
                    state <= F;
                else
                    state <= A;
                z <= 0;
            end
            E: begin
                if (w == 0)
                    state <= E;
                else
                    state <= D;
                z <= 1;
            end
            F: begin
                if (w == 0)
                    state <= C;
                else
                    state <= D;
                z <= 1;
            end
            default:
                state <= A;
        endcase
    end
end

endmodule
