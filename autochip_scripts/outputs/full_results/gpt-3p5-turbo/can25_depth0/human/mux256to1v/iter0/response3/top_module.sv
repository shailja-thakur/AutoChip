module top_module (
     input [1023:0] in,
     input [7:0] sel,
     output [3:0] out
);

// Create a wire to store the selected 4-bit input
wire [3:0] selected_input;

// Define the multiplexer
always @* begin
    case(sel)
        0: selected_input = in[3:0];
        1: selected_input = in[7:4];
        2: selected_input = in[11:8];
        // Add more cases for other selections
        // ...
    endcase
end

// Assign the output to the selected input
assign out = selected_input;

endmodule
