module top_module (
    input in,
    input [1:0] state,
    output reg [1:0] next_state,
    output reg out
);
    
    // State encoding
    localparam A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11;
    
    // State transition and output logic
    always @(*) begin
        case (state)
            A: begin
                next_state = (in) ? B : A;
                out = 1'b0;
            end
            B: begin
                next_state = (in) ? B : C;
                out = 1'b0;
            end
            C: begin
                next_state = (in) ? D : A;
                out = 1'b0;
            end
            D: begin
                next_state = (in) ? B : C;
                out = 1'b1;
            end
            default: begin
                next_state = A; // Default to state A
                out = 1'b0; // Default output
            end
        endcase
    end

endmodule
