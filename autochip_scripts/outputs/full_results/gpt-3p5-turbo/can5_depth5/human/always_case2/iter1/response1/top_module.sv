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
    
    $monitor($time, " in=%b, pos=%b", in, pos);
    
    #10 in = 4'b0000;
    #10 in = 4'b0001;
    #10 in = 4'b0010;
    #10 in = 4'b0100;
    #10 in = 4'b1000;
    #10 in = 4'b1001;
    #10 in = 4'b1100;
    #10 in = 4'b1111;
    
    $finish;
end

endmodule
