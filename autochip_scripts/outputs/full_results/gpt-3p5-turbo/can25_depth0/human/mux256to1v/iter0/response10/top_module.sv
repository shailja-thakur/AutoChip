module top_module (
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out
);

wire [255:0] in_4bit [0:63];
wire [7:0] sel_mult;
reg [7:0] addr;

// Map the 1024-bit input to 4-bit inputs
generate
    genvar i;
    for (i = 0; i < 64; i = i + 1) begin : map_inputs
        assign in_4bit[i] = in[i*16 +: 16];
    end
endgenerate

// Use sel to determine the desired address for the multiplexer
always @(*) begin
    case (sel)
        0: sel_mult = addr[1:0];
        1: sel_mult = addr[3:2];
        2: sel_mult = addr[5:4];
        3: sel_mult = addr[7:6];
        // Add case statements for all other sel values as needed
        // ...
        default: sel_mult = 0;
    endcase
end

// Assign address
always @(posedge clk) begin
    addr <= sel_mult;
end

// Output the selected 4-bit input
assign out = in_4bit[sel_mult];

endmodule
