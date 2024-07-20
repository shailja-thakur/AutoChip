module top_module (
    input [1023:0] in,
    input [7:0] sel,
    output reg [3:0] out
);

    // Create a temp_wire wire to store the selected input
    wire [3:0] temp_wire;
    
    // Create a temporary reg to store the selected input
    reg [255:0] selected_input;

    // Determine the index of the selected input
    always @* begin
        case(sel)
            0: temp_wire = in[3:0];
            1: temp_wire = in[7:4];
            2: temp_wire = in[11:8];
            // Add more cases for the remaining selections
        
            default: temp_wire = 0; // Set default value to 0
        endcase
    end

    // Assign the output to the selected input
    always @* begin
        case(sel)
            0: selected_input = in[3:0];
            1: selected_input = in[7:4];
            2: selected_input = in[11:8];
            // Add more cases for the remaining selections
            
            default: selected_input = 0; // Set default value to 0
        endcase
    end

    always @(posedge clk) begin
        out <= selected_input;
    end
endmodule
