module priority_encoder (
    input [3:0] in,
    output reg [1:0] pos
);

always @(*)
begin
    case(in)
        4'b0001: pos = 2'b00;
        4'b0010: pos = 2'b01;
        4'b0100: pos = 2'b10;
        4'b1000: pos = 2'b11;
        default: pos = 2'b00; // for input of all zeros, output zero
    endcase
end

endmodule
module top_module (
    input [3:0] in,
    output reg [1:0] pos
);

priority_encoder priority_encoder1 (
    .in(in),
    .pos(pos)
);

initial
begin
    $dumpfile("wave.vcd");
    $dumpvars(0, top_module);
    $display("Simulation Started");
    $monitor("in[%0d] = %b, pos = %b", $time, in, pos);
    
    //Reset
    in <= 4'b0000;

    // Test Input 1
    #10 in <= 4'b0001;

    // Test Input 2
    #10 in <= 4'b0010;

    // Test Input 3
    #10 in <= 4'b0100;

    // Test Input 4
    #10 in <= 4'b1000;

    // Test Input 5 (No High Bits)
    #10 in <= 4'b0000;

    #10 $finish;
end

endmodule
