module top_module (
    input clk,
    input enable,
    input S,
    input A,
    input B,
    input C,
    output reg Z
);

reg [7:0] Q;
wire [7:0] Z_mux;

// Create an 8-bit shift register with 8 D-type flip-flops
always @(posedge clk) begin
    if (enable) begin
        Q <= {S, Q[7:1]};
    end
end

// Multiplexer to select the output based on input A, B, C
assign Z_mux = (A == 0 && B == 0 && C == 0) ? Q[0] :
              (A == 0 && B == 0 && C == 1) ? Q[1] :
              (A == 0 && B == 1 && C == 0) ? Q[2] :
              (A == 0 && B == 1 && C == 1) ? Q[3] :
              (A == 1 && B == 0 && C == 0) ? Q[4] :
              (A == 1 && B == 0 && C == 1) ? Q[5] :
              (A == 1 && B == 1 && C == 0) ? Q[6] :
                                           Q[7];

// Assign the output Z
always @(*) begin
    Z = Z_mux;
end

endmodule
