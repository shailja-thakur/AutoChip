module top_module (
    input do_sub,
    input [7:0] a,
    input [7:0] b,
    output reg [7:0] out,
    output reg result_is_zero
);

    always @ (*)
    begin
        case (do_sub)
            1'b0: 
                begin
                    out = a + b;
                    if (out == 0)
                        result_is_zero = 1'b1;
                    else
                        result_is_zero = 1'b0;
                end
            
            1'b1: 
                begin
                    out = a - b;
                    if (out == 0)
                        result_is_zero = 1'b1;
                    else
                        result_is_zero = 1'b0;
                end
        endcase
    end

endmodule
