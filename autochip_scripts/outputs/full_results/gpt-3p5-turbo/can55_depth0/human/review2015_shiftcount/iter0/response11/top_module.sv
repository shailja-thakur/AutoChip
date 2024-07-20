module top_module(
    input clk,
    input shift_ena,
    input count_ena,
    input data,
    output reg [3:0] q);

    reg [3:0] reg_q;
    
    always @(posedge clk) begin
        if (shift_ena && ~count_ena) begin
            reg_q <= {data, reg_q[3:1]};
        end else if (~shift_ena && count_ena) begin
            reg_q <= reg_q - 1;
        end else begin
            reg_q <= reg_q;
        end
    end
    
    assign q = reg_q;
endmodule
