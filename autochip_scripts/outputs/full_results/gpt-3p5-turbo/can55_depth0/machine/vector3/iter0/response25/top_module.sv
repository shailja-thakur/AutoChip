module top_module (
    input [4:0] a,
    input [4:0] b,
    input [4:0] c,
    input [4:0] d,
    input [4:0] e,
    input [4:0] f,
    output [7:0] w,
    output [7:0] x,
    output [7:0] y,
    output [7:0] z
);

    wire [7:0] concat_input;
    wire [1:0] last_port;
    
    assign concat_input = {a, b, c, d, e, f, 2'b11};
    assign last_port = concat_input[7:6];
    
    assign w = 8'b0;
    assign x = 8'b0;
    assign y = 8'b0;
    assign z = 8'b0;
    
    always @* begin
        case (last_port)
            2'b00: w = concat_input;
            2'b01: x = concat_input;
            2'b10: y = concat_input;
            2'b11: z = concat_input;
        endcase
    end    
    
endmodule
