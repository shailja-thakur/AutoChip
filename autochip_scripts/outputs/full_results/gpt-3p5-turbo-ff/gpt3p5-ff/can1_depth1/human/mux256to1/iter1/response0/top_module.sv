module top_module (
    input [255:0] in,
    input [7:0] sel,
    output out
);
    wire out_wire; // Declare a wire for intermediate connection

    always @(*) begin
        case(sel)
            8'b00000000: out_wire = in[0];
            8'b00000001: out_wire = in[1];
            8'b00000010: out_wire = in[2];
            8'b00000011: out_wire = in[3];
            8'b00000100: out_wire = in[4];
            8'b00000101: out_wire = in[5];
            8'b00000110: out_wire = in[6];
            8'b00000111: out_wire = in[7];
            // continue for the remaining 248 cases
        endcase
    end

    assign out = out_wire; // Connect the output wire to the output port

endmodule
