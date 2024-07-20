module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

    parameter A = 3'b000, B = 3'b001, C = 3'b010, D = 3'b011, E = 3'b100, F = 3'b101;
    reg [2:0] state, next_state;

    // State transition logic
    always @(posedge clk, posedge reset) begin
        if (reset) begin
            state <= A;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            A: next_state = (w == 0) ? A : B;
            B: next_state = (w == 0) ? D : C;
            C: next_state = (w == 0) ? D : E;
            D: next_state = (w == 0) ? A : F;
            E: next_state = (w == 0) ? D : E;
            F: next_state = (w == 0) ? D : C;
            default: next_state = A;
        endcase
    end

    // Output logic
    assign z = (state == E) | (state == F);

endmodule
