module top_module (
    input logic [4:1] x,
    output logic f
);

always @* begin
    case (x)
        4'b0000: f = 1;
        4'b0001: f = 0;
        4'b0010: f = 0;
        4'b0011: f = 1;
        4'b0100: f = 1;
        4'b0101: f = 1;
        4'b0110: f = 0;
        4'b0111: f = 0;
        4'b1000: f = 1;
        4'b1001: f = 1;
        4'b1010: f = 0;
        default: f = 1;
    endcase
end

initial begin
    $display("x f");
    $monitor("%b %b", x, f);
    #10 x = 4'b0000; // Expected output: f = 1
    #10 x = 4'b0001; // Expected output: f = 0
    #10 x = 4'b0010; // Expected output: f = 0
    #10 x = 4'b0011; // Expected output: f = 1
    #10 x = 4'b0100; // Expected output: f = 1
    #10 x = 4'b0101; // Expected output: f = 1
    #10 x = 4'b0110; // Expected output: f = 0
    #10 x = 4'b0111; // Expected output: f = 0
    #10 x = 4'b1000; // Expected output: f = 1
    #10 x = 4'b1001; // Expected output: f = 1
    #10 x = 4'b1010; // Expected output: f = 0
    #10 x = 4'b1011; // Expected output: f = 1
    
    $finish; // End the simulation
end

endmodule
