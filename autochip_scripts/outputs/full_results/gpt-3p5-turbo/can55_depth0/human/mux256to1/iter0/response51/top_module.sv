module top_module (
    input [255:0] in,
    input [7:0] sel,
    output out
);

    // Create an intermediate wire to store the selected input
    wire [7:0] selected_input;
    
    // Use a case statement to select the input based on the value of 'sel'
    // sel = 0 selects in[0], sel = 1 selects in[1], etc.
    always @* begin
        case(sel)
            8'b00000000: selected_input = in[7:0];
            8'b00000001: selected_input = in[15:8];
            8'b00000010: selected_input = in[23:16];
            // More cases for the remaining inputs...
            default: selected_input = 8'b0; // Default case
        endcase
    end
    
    // Assign the selected input to the output
    assign out = selected_input;
    
endmodule
