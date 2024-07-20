module top_module (
    input in,
    input [1:0] state,
    output reg [1:0] next_state,
    output out
);

    // Define state encoding
    localparam A = 2'b00,
               B = 2'b01,
               C = 2'b10,
               D = 2'b11;

    // Always block to determine next state
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
            default: begin
                next_state = A; // Default to state A for safety
            end
        endcase
    end

    // Output logic
    assign out = (state == D);

endmodule
