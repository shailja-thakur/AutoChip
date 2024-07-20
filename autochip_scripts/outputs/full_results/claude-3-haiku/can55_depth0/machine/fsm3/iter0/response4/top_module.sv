module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    // State register
    reg [1:0] state;

    // State definitions
    localparam A = 2'd0, B = 2'd1, C = 2'd2, D = 2'd3;

    // Next state logic
    always @(*) begin
        case (state)
            A: state = (in) ? B : A;
            B: state = (in) ? B : C;
            C: state = (in) ? D : A;
            D: state = (in) ? B : C;
        endcase
    end

    // Output logic
    assign out = (state == D);

    // State register update
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;
        else
            state <= state;
    end

endmodule
