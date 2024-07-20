module top_module (
    input [255:0] in,
    input [7:0] sel,
    output out
);

    wire [255:0] selected_inputs;
    reg [7:0] shift_sel;
    reg [255:0] shifted_in;

    always @(*) begin
        shift_sel = sel;
        case(shift_sel)
            0: shifted_in = in[7:0];
            1: shifted_in = in[15:8];
            2: shifted_in = in[23:16];
            3: shifted_in = in[31:24];
            4: shifted_in = in[39:32];
            5: shifted_in = in[47:40];
            6: shifted_in = in[55:48];
            7: shifted_in = in[63:56];
            8: shifted_in = in[71:64];
            9: shifted_in = in[79:72];
            10: shifted_in = in[87:80];
            11: shifted_in = in[95:88];
            12: shifted_in = in[103:96];
            13: shifted_in = in[111:104];
            14: shifted_in = in[119:112];
            15: shifted_in = in[127:120];
            16: shifted_in = in[135:128];
            17: shifted_in = in[143:136];
            18: shifted_in = in[151:144];
            19: shifted_in = in[159:152];
            20: shifted_in = in[167:160];
            21: shifted_in = in[175:168];
            22: shifted_in = in[183:176];
            23: shifted_in = in[191:184];
            24: shifted_in = in[199:192];
            25: shifted_in = in[207:200];
            26: shifted_in = in[215:208];
            27: shifted_in = in[223:216];
            28: shifted_in = in[231:224];
            29: shifted_in = in[239:232];
            30: shifted_in = in[247:240];
            31: shifted_in = in[255:248];
            default: shifted_in = 0;
        endcase
    end

    assign selected_inputs = shifted_in;
    assign out = selected_inputs[0];

endmodule
