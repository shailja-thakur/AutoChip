module top_module( 
    input [15:0] a, b, c, d, e, f, g, h, i,
    input [3:0] sel,
    output [15:0] out );

    // Insert your code here

    always @(sel or a or b or c or d or e or f or g or h or i) begin
        case (sel)
            2'b00: out <= a;
            2'b01: out <= b;
            2'b10: out <= c;
            2'b11: out <= d;
            2'b000: out <= e;
            2'b001: out <= f;
            2'b010: out <= g;
            2'b011: out <= h;
            2'b100: out <= i;
            default: out <= 16'hffff;
        endcase
    end

endmodule