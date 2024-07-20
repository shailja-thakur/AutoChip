module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

    wire Y1_sig;
    wire Y3_sig;

    assign Y1 = Y1_sig;
    assign Y3 = Y3_sig;

    always @*
    begin
        case (y)
            6'b000001: {Y1_sig, Y3_sig} = 2'b00; // State A
            6'b000010: {Y1_sig, Y3_sig} = 2'b00; // State B
            6'b000100: {Y1_sig, Y3_sig} = 2'b01; // State C
            6'b001000: {Y1_sig, Y3_sig} = 2'b00; // State D
            6'b010000: {Y1_sig, Y3_sig} = 2'b10; // State E
            6'b100000: {Y1_sig, Y3_sig} = 2'b11; // State F
            default: {Y1_sig, Y3_sig} = 2'b00; // Default state
        endcase
    end

endmodule
