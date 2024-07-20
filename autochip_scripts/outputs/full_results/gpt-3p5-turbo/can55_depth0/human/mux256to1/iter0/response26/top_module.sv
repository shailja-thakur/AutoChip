module top_module (
    input [255:0] in,
    input [7:0] sel,
    output out
);
    reg [255:0] mux_out;
    
    always @* begin
        case (sel)
            8'b00000000: mux_out = in[0];
            8'b00000001: mux_out = in[1];
            8'b00000010: mux_out = in[2];
            8'b00000011: mux_out = in[3];
            // add remaining cases for all 256 inputs
            // ...
            default: mux_out = 8'b0; // default case, select input 0
        endcase
    end
    
    assign out = mux_out;
    
endmodule
