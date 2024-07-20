module top_module (
    input clk,
    input j,
    input k,
    output reg Q
);

always @(posedge clk) begin
    case ({j, k})
        2'b00: Q <= Q;
        2'b01: Q <= 0;
        2'b10: Q <= 1;
        2'b11: Q <= ~Q;
        default: Q <= Q; // default case to handle any unexpected values
    endcase
end

endmodule
