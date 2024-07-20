module top_module (
    input in,
    input [3:0] state,
    output reg [3:0] next_state,
    output reg out
);

    // State encoding
    localparam A = 4'b0001;
    localparam B = 4'b0010;
    localparam C = 4'b0100;
    localparam D = 4'b1000;

    always @(*) begin
        // Default assignments
        next_state = 4'b0000;
        out = 1'b0;

        case (state)
            A: begin
                if (in) next_state = B;
                else next_state = A;
                out = 1'b0;
            end
            B: begin
                if (in) next_state = B;
                else next_state = C;
                out = 1'b0;
            end
            C: begin
                if (in) next_state = D;
                else next_state = A;
                out = 1'b0;
            end
            D: begin
                if (in) next_state = B;
                else next_state = C;
                out = 1'b1;
            end
            default: begin
                next_state = 4'b0000;
                out = 1'b0;
            end
        endcase
    end

endmodule
