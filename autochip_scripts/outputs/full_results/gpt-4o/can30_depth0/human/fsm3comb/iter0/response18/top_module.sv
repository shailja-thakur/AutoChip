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

    // Combinational logic for next state and output
    always @(*) begin
        case (state)
            A: begin
                out = 1'b0;
                if (in == 1'b0) 
                    next_state = A;
                else 
                    next_state = B;
            end
            B: begin
                out = 1'b0;
                if (in == 1'b0) 
                    next_state = C;
                else 
                    next_state = B;
            end
            C: begin
                out = 1'b0;
                if (in == 1'b0) 
                    next_state = A;
                else 
                    next_state = D;
            end
            D: begin
                out = 1'b1;
                if (in == 1'b0) 
                    next_state = C;
                else 
                    next_state = B;
            end
            default: begin
                next_state = A;  // default state in case of invalid state
                out = 1'b0;
            end
        endcase
    end
endmodule
