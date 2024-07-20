module top_module (
    input [255:0] in,
    input [7:0] sel,
    output out
);

    reg [7:0] shift_sel;
    wire [255:0] selected_inputs;

    always @(*) begin
        case(sel)
            0: selected_inputs = in[7:0];
            1: selected_inputs = in[15:8];
            2: selected_inputs = in[23:16];
            3: selected_inputs = in[31:24];
            4: selected_inputs = in[39:32];
            5: selected_inputs = in[47:40];
            6: selected_inputs = in[55:48];
            7: selected_inputs = in[63:56];
            8: selected_inputs = in[71:64];
            9: selected_inputs = in[79:72];
            10: selected_inputs = in[87:80];
            11: selected_inputs = in[95:88];
            12: selected_inputs = in[103:96];
            13: selected_inputs = in[111:104];
            14: selected_inputs = in[119:112];
            15: selected_inputs = in[127:120];
            16: selected_inputs = in[135:128];
            17: selected_inputs = in[143:136];
            18: selected_inputs = in[151:144];
            19: selected_inputs = in[159:152];
            20: selected_inputs = in[167:160];
            21: selected_inputs = in[175:168];
            22: selected_inputs = in[183:176];
            23: selected_inputs = in[191:184];
            24: selected_inputs = in[199:192];
            25: selected_inputs = in[207:200];
            26: selected_inputs = in[215:208];
            27: selected_inputs = in[223:216];
            28: selected_inputs = in[231:224];
            29: selected_inputs = in[239:232];
            30: selected_inputs = in[247:240];
            31: selected_inputs = in[255:248];
        endcase
    end

    assign out = selected_inputs[0];

endmodule
