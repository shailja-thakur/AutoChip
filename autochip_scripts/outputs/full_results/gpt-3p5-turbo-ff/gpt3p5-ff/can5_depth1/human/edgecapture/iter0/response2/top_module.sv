module top_module(
    input clk,
    input reset,
    input [31:0] in,
    output reg [31:0] out);

    reg [31:0] prev_in;
    reg [31:0] capture;

    always @(posedge clk or posedge reset) begin
        if (reset)
            capture <= 0;
        else begin
            if (in[0] == 1'b1 && prev_in[0] == 1'b0)
                capture[0] <= 1'b1;
            else
                capture[0] <= 1'b0;

            for (int i=1; i<32; i=i+1) begin
                if (in[i] == 1'b1 && prev_in[i] == 1'b0)
                    capture[i] <= 1'b1;
                else
                    capture[i] <= capture[i-1];
            end
        end
    end

    always @(posedge clk) begin
        if (reset)
            out <= 0;
        else
            out <= capture;
    end
    
    always @(posedge clk) begin
        prev_in <= in;
    end

endmodule
