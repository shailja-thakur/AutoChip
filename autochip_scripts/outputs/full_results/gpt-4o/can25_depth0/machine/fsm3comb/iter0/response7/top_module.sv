module top_module (
    input in,
    input [1:0] state,
    output reg [1:0] next_state,
    output out
);

    // Encode states A, B, C, D as 2'b00, 2'b01, 2'b10, 2'b11 respectively
    localparam A = 2'b00;
    localparam B = 2'b01;
    localparam C = 2'b10;
    localparam D = 2'b11;

    always @(*) begin
        case (state)
            A: begin
                if (in) 
                    next_state = B;
                else 
                    next_state = A;
            end
            B: begin
                if (in) 
                    next_state = B;
                else 
                    next_state = C;
            end
            C: begin
                if (in) 
                    next_state = D;
                else 
                    next_state = A;
            end
            D: begin
                if (in) 
                    next_state = B;
                else 
                    next_state = C;
            end
            default: next_state = A;  // Default state to prevent latches
        endcase
    end

    assign out = (state == D) ? 1'b1 : 1'b0;

endmodule
