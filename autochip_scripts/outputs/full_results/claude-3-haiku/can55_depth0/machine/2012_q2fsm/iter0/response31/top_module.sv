module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

    // Define the states
    localparam [2:0] A = 3'd0, B = 3'd1, C = 3'd2, D = 3'd3, E = 3'd4, F = 3'd5;

    // State register
    reg [2:0] state;

    // Next state logic
    always @(*)
    begin
        case (state)
            A: state = (w == 1'b0) ? A : B;
            B: state = (w == 1'b0) ? D : C;
            C: state = (w == 1'b0) ? D : E;
            D: state = (w == 1'b0) ? A : F;
            E: state = (w == 1'b0) ? D : E;
            F: state = (w == 1'b0) ? D : C;
            default: state = A;
        endcase
    end

    // State update logic
    always @(posedge clk or posedge reset)
    begin
        if (reset)
            state <= A;
        else
            state <= state;
    end

    // Output logic
    assign z = (state == E) | (state == F);

endmodule
