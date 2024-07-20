module top_module (
    input [4:1] x,
    output reg f
);

// Implementing the function f using a case statement
always @*
begin
    case(x)
        4'b0011, 4'b1110: f = 1'b1;
        default: f = 1'b0;
    endcase
end

endmodule
