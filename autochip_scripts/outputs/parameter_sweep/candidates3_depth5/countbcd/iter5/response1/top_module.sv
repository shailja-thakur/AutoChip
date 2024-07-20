module top_module(
    input wire clk,
    input wire reset,
    output reg [3:1] ena,
    output reg [15:0] q);
    
    reg [3:0] q_ones;
    reg [3:0] q_tens;
    reg [3:0] q_hundreds;
    wire [2:0] q_ones_enable;
    wire [2:0] q_tens_enable;
    wire [2:0] q_hundreds_enable;
    
    always @(posedge clk or posedge reset) begin
        if (reset)
            q <= 0;
        else begin
            if (q_ones_enable[0])
                q_ones <= (q_ones == 4'b1001) ? 4'b0000 : q_ones + 1;
            if (q_tens_enable[0])
                q_tens <= (q_tens == 4'b1001) ? 4'b0000 : q_tens + 1;
            if (q_hundreds_enable[0])
                q_hundreds <= (q_hundreds == 4'b1001) ? 4'b0000 : q_hundreds + 1;
        end
    end
    
    assign ena[1] = (q_ones_enable[0] || q_ones_enable[1] || q_ones_enable[2]);
    assign ena[2] = (q_tens_enable[0] || q_tens_enable[1] || q_tens_enable[2]);
    assign ena[3] = (q_hundreds_enable[0] || q_hundreds_enable[1] || q_hundreds_enable[2]);
    
    always @(posedge clk) begin
        q_ones_enable <= ena;
        q_tens_enable <= {ena[2], ena[1]};
        q_hundreds_enable <= {ena[3], ena[2]};
        q <= {q_hundreds, q_tens, q_ones};
    end
    
endmodule
