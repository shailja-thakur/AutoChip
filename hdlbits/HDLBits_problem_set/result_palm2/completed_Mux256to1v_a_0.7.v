module top_module( 
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out );

    // Create a 256-bit register for each of the 256 4-bit inputs.
    always @(posedge clk) begin
        if (reset) begin
            for (int i = 0; i < 256; i++) begin
                reg_in[i] <= 0;
            end
        end else begin
            for (int i = 0; i < 256; i++) begin
                reg_in[i] <= in[i*4+3:i*4];
            end
        end
    end

    // Create a 4-bit register for the output.
    always @(posedge clk) begin
        if (reset) begin
            out <= 0;
        end else begin
            out <= reg_in[sel];
        end
    end

endmodule