module top_module (
    input in,
    input [1:0] state,
    output reg [1:0] next_state,
    output reg out
);

    // State encoding
    localparam A = 2'b00, 
               B = 2'b01, 
               C = 2'b10, 
               D = 2'b11;

    // State transition logic
    always @(*) begin
        case (state)
            A: next_state = in ? B : A;
            B: next_state = in ? B : C;
            C: next_state = in ? D : A;
            D: next_state = in ? B : C;
            default: next_state = A;
        endcase
    end

    // Output logic
    always @(*) begin
        if (state == D)
            out = 1;
        else
            out = 0;
    end
endmodule
