module top_module (
    input a, 
    input b,
    input c,
    input d,
    output reg out
);

    always @(*) begin
        case ({a, b, c, d})
            4'b00??: out = 1;
            4'b01??: out = d;
            4'b10??: out = d;
            default: out = 1;
        endcase
    end
endmodule
