module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

    // State register
    reg [2:0] state;
    parameter A = 3'd0, B = 3'd1, C = 3'd2, D = 3'd3, E = 3'd4, F = 3'd5;

    // Next state logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= A;
        end
        else begin
            case (state)
                A: state <= (w == 1'b0) ? A : B;
                B: state <= (w == 1'b0) ? D : C;
                C: state <= (w == 1'b0) ? D : E;
                D: state <= (w == 1'b0) ? A : F;
                E: state <= (w == 1'b0) ? D : E;
                F: state <= (w == 1'b0) ? D : C;
            endcase
        end
    end

    // Output logic
    assign z = (state == E || state == F);

endmodule
