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
        case (state)
            A: begin
                next_state = (in) ? B : A;
            end
            B: begin
                next_state = (in) ? B : C;
            end
            C: begin
                next_state = (in) ? D : A;
            end
            D: begin
                next_state = (in) ? B : C;
            end
            default: begin
                next_state = A; // Default state
            end
        endcase
    end

    always @(*) begin
        out = (state == D) ? 1'b1 : 1'b0;
    end

endmodule
