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
        // Default output value
        out = 0;
        
        case (state)
            A: begin
                next_state = (in == 1'b0) ? A : B;
            end
            B: begin
                next_state = (in == 1'b0) ? C : B;
            end
            C: begin
                next_state = (in == 1'b0) ? A : D;
            end
            D: begin
                next_state = (in == 1'b0) ? C : B;
                out = 1; // Output is 1 in state D
            end
            default: begin
                next_state = A;
            end
        endcase
    end

endmodule
