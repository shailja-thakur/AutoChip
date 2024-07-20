module top_module (
    input in,
    input [1:0] state,
    output reg [1:0] next_state,
    output out
);

    // Define states using local parameters for readability
    localparam A = 2'b00;
    localparam B = 2'b01;
    localparam C = 2'b10;
    localparam D = 2'b11;

    // Determine the next state based on the current state and input
    always @(*) begin
        case (state)
            A: begin
                if (in == 1'b1) 
                    next_state = B;
                else 
                    next_state = A;
            end
            B: begin
                if (in == 1'b1) 
                    next_state = B;
                else 
                    next_state = C;
            end
            C: begin
                if (in == 1'b1)
                    next_state = D;
                else 
                    next_state = A;
            end
            D: begin
                if (in == 1'b1)
                    next_state = B;
                else 
                    next_state = C;
            end
            default: 
                next_state = A; // Default state
        endcase
    end

    // Assign output 'out' to be high when in state D
    assign out = (state == D);

endmodule
