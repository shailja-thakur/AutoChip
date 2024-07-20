module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);
    reg [7:0] byte1;
    reg [7:0] byte2;
    reg [7:0] byte3;
    reg searching;
    reg done_reg;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            searching <= 1'b0;
            byte1 <= 8'b0;
            byte2 <= 8'b0;
            byte3 <= 8'b0;
            done_reg <= 1'b0;
        end else begin
            if (searching) begin
                if (in[3] == 1'b1) begin
                    byte1 <= in;
                    searching <= 1'b0;
                end
            end else begin
                byte2 <= in;
                searching <= 1'b1;
            end
            if (!searching) begin
                byte3 <= in;
                done_reg <= 1'b1;
            end
        end
    end
    
    assign done = done_reg;
    
endmodule
