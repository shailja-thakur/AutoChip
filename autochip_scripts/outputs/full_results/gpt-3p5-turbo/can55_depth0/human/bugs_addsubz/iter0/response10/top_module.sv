module top_module (
    input do_sub,
    input [7:0] a,
    input [7:0] b,
    output reg [7:0] out,
    output reg result_is_zero
);

    always @(*) begin
        case (do_sub)
          0: out = a + b;
          1: out = a - b;
        endcase

        if (out == 0) // Change ~out to out == 0
            result_is_zero = 1;
        else
            result_is_zero = 0; // Add an else condition to set result_is_zero to 0 when out is not zero
    end

endmodule
