module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

    // State register
    reg [2:0] state;

    // State definitions
    localparam A = 3'd0, B = 3'd1, C = 3'd2, D = 3'd3, E = 3'd4, F = 3'd5;

    // Next state logic
    always @(posedge clk) begin
        if (reset) begin
            state <= A;
        end else begin
            case (state)
                A: state <= (w) ? B : A;
                B: state <= (w) ? C : D;
                C: state <= (w) ? E : D;
                D: state <= (w) ? F : A;
                E: state <= (w) ? E : D;
                F: state <= (w) ? C : D;
                default: state <= A;
            endcase
        end
    end

    // Output logic
    assign z = (state == E) || (state == F);

endmodule
