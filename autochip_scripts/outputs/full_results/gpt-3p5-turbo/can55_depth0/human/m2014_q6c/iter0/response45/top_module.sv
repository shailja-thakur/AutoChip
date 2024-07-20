module top_module (
    input [6:1] y,
    input w,
    output reg Y2,
    output reg Y4
);

    always @*
    begin
        case(y)
            6'd1: {Y2, Y4} = 2'b00; // State A
            6'd2: {Y2, Y4} = 2'b00; // State B
            6'd4: {Y2, Y4} = 2'b01; // State C
            6'd8: {Y2, Y4} = 2'b10; // State D
            6'd16: {Y2, Y4} = 2'b00; // State E
            6'd32: {Y2, Y4} = 2'b00; // State F
            default: {Y2, Y4} = 2'b00; // Default value
        endcase
    end

endmodule
