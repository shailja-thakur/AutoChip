module top_module (
    input [1023:0] in,
    input [7:0] sel,
    output reg [3:0] out
);

    reg [3:0] out_sync;

    always @* begin
        case (sel)
            0: out_sync = in[3:0];
            1: out_sync = in[7:4];
            2: out_sync = in[11:8];
            // Add more cases for other selections
            default: out_sync = 4'b0; // Default value when select is out of range
        endcase
    end

    // Synchronize the output to avoid glitches
    always @(posedge clk) begin
        out <= out_sync;
    end

endmodule
