module top_module (
    input in,
    input [1:0] state,
    output reg [1:0] next_state,
    output reg out
);

    // State definitions
    localparam A = 2'b00;
    localparam B = 2'b01;
    localparam C = 2'b10;
    localparam D = 2'b11;

    always @(*) begin
        case (state)
            A: begin
                out = 0;
                if (in == 0)
                    next_state = A;
                else
                    next_state = B;
            end
            B: begin
                out = 0;
                if (in == 0)
                    next_state = C;
                else
                    next_state = B;
            end
            C: begin
                out = 0;
                if (in == 0)
                    next_state = A;
                else
                    next_state = D;
            end
            D: begin
                out = 1;
                if (in == 0)
                    next_state = C;
                else
                    next_state = B;
            end
            default: begin
                next_state = A;
                out = 0;
            end
        endcase
    end

endmodule
