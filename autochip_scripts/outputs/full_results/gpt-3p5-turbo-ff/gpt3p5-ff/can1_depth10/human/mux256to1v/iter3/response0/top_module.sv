module top_module (
    input [1023:0] in,
    input [7:0] sel,
    output reg [3:0] out
);

    always @* begin
        case (sel)
            0: out = in[3:0];
            1: out = in[7:4];
            2: out = in[11:8];
            // Add more cases for other selections
            default: out = 4'b0; // Default value when select is out of range
        endcase
    end

    // Synchronize the output to avoid glitches
    always @(posedge clk) begin
        out_sync <= out;
    end

endmodule
