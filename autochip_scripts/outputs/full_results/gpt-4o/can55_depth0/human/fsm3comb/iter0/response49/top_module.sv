module top_module (
    input in,
    input [1:0] state,
    output reg [1:0] next_state,
    output reg out
);

    // State encoding
    localparam A = 2'b00;
    localparam B = 2'b01;
    localparam C = 2'b10;
    localparam D = 2'b11;

    always @(*) begin
        // Default next state and output
        next_state = state;
        out = 0;

        case (state)
            A: begin
                if (in == 1'b0)
                    next_state = A;
                else
                    next_state = B;
                out = 0;
            end
            B: begin
                if (in == 1'b0)
                    next_state = C;
                else
                    next_state = B;
                out = 0;
            end
            C: begin
                if (in == 1'b0)
                    next_state = A;
                else
                    next_state = D;
                out = 0;
            end
            D: begin
                if (in == 1'b0)
                    next_state = C;
                else
                    next_state = B;
                out = 1;
            end
            default: begin
                next_state = A;
                out = 0;
            end
        endcase
    end
endmodule
