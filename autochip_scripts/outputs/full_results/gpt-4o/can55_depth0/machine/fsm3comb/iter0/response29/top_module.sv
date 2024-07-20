module top_module (
    input in,
    input [1:0] state,
    output reg [1:0] next_state,
    output out
);

    // Define the state encoding
    localparam A = 2'b00;
    localparam B = 2'b01;
    localparam C = 2'b10;
    localparam D = 2'b11;

    // Combinational logic for next state
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
            default: next_state = A; // default to state A on invalid state
        endcase
    end

    // Output signal 'out' is high when in state D
    assign out = (state == D);

endmodule
