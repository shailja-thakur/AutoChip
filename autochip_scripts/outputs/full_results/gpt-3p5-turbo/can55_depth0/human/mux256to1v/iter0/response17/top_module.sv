module top_module (
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out
);

    // Create an array to store the selected 4-bit input
    reg [3:0] selected_input;

    // Use a case statement to select the appropriate bits based on the value of sel
    always @(*) begin
        case(sel)
            0: selected_input = in[3:0];   // Select bits in[3:0]
            1: selected_input = in[7:4];   // Select bits in[7:4]
            2: selected_input = in[11:8];  // Select bits in[11:8]
            3: selected_input = in[15:12]; // Select bits in[15:12]
            // Add cases for sel = 4 to 255 here
            default: selected_input = 4'b0; // Default case, select all 0's
        endcase
    end

    // Assign the selected input to the output
    assign out = selected_input;

endmodule
