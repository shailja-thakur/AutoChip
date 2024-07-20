module top_module (
    input in,
    input [1:0] state,
    output reg [1:0] next_state,
    output out
);

    // Define states
    parameter A = 2'b00;
    parameter B = 2'b01;
    parameter C = 2'b10;
    parameter D = 2'b11;

    // Combinational logic for state transition
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

            default: next_state = A;  // Default state
        endcase
    end

    // Output logic
    assign out = (state == D);

endmodule
