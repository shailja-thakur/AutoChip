module top_module(
    input clk,
    input reset,
    input [31:0] in,
    output reg [31:0] out);

    reg [31:0] d_last;

    always @(posedge clk) begin
        if (reset) begin
            out <= 0;
            d_last <= 0;
        end else begin
            d_last <= in;
            out <= out | (~in & d_last);
        end
    end

    initial begin
        // Reset the module
        reset <= 1;
        clk <= 0;
        #10;
        reset <= 0;
        
        // Provide test inputs
        in <= 32'b01010101010101010101010101010101;
        #10;
        in <= 32'b00110011001100110011001100110011;
        #10;
        in <= 32'b11111111111111111111111111111111;
        #10;
        
        // End simulation
        $finish;
    end

endmodule
