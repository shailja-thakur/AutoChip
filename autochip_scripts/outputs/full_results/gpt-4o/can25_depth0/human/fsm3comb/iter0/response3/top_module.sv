module top_module (
    input in,
    input [1:0] state,
    output reg [1:0] next_state,
    output reg out
);

    // State encoding
    parameter A = 2'b00;
    parameter B = 2'b01;
    parameter C = 2'b10;
    parameter D = 2'b11;

    // Combinational logic for next_state and out
    always @(*) begin
        case (state)
            A: begin
                next_state = (in == 1'b0) ? A : B;
                out = 1'b0;
            end

            B: begin
                next_state = (in == 1'b0) ? C : B;
                out = 1'b0;
            end

            C: begin
                next_state = (in == 1'b0) ? A : D;
                out = 1'b0;
            end

            D: begin
                next_state = (in == 1'b0) ? C : B;
                out = 1'b1;
            end

            default: begin
                next_state = A;
                out = 1'b0;
            end
        endcase
    end
endmodule
