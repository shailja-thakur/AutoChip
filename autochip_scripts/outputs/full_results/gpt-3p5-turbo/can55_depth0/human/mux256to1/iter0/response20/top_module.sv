module top_module (
    input [255:0] in,
    input [7:0] sel,
    output  out
);

reg [0:255] temp_out;

always @(*) begin
    case(sel)
        8'b00000000: temp_out = in[0];
        8'b00000001: temp_out = in[1];
        8'b00000010: temp_out = in[2];
        8'b00000011: temp_out = in[3];
        // ...
        // repeat this pattern for all 256 cases
        // ...
        8'b11111111: temp_out = in[255];
    endcase
end

assign out = temp_out;

endmodule
