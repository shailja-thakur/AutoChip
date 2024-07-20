module top_module (
    input clk,
    input a,
    output reg [2:0] q
);

    reg [2:0] q_next;
    reg [2:0] q_reg;

    always @(posedge clk) begin
        q_reg <= q_next;
    end

    always @(posedge clk or posedge a) begin
        case (q_reg)
            3'b000: q_next = a ? 3'b100 : 3'b001;
            3'b100: q_next = 3'b101;
            3'b101: q_next = 3'b110;
            default: q_next = 3'b000;
        endcase
    end
    
    assign q = q_reg;
endmodule
