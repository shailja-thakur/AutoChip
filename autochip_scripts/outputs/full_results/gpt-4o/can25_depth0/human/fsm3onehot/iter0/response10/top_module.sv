module top_module (
    input in,
    input [3:0] state,
    output reg [3:0] next_state,
    output reg out
);

    // Define one-hot state encoding
    localparam A = 4'b0001;
    localparam B = 4'b0010;
    localparam C = 4'b0100;
    localparam D = 4'b1000;

    // Combinational logic for state transition
    always @* begin
        case (state)
            A: 
                next_state = in ? B : A;
            B: 
                next_state = in ? B : C;
            C: 
                next_state = in ? D : A;
            D: 
                next_state = in ? B : C;
            default: 
                next_state = A; // Default state
        endcase
    end

    // Combinational logic for output
    always @* begin
        case (state)
            D: out = 1;
            default: out = 0;
        endcase
    end

endmodule
