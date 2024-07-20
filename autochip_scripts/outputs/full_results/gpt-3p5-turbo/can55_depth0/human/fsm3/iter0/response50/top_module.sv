module top_module (
    input clk,
    input in,
    input areset,
    output out
);

reg [1:0] state;
reg out_reg;
	
parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;

always @(posedge clk or posedge areset) begin
    if (areset)
        state <= A;
    else
        case (state)
            A: state <= in ? B : A;
            B: state <= in ? B : C;
            C: state <= in ? D : A;
            D: state <= in ? B : C;
        endcase
    end
end

always @(state) begin
    case (state)
        A: out_reg = 1'b0;
        D: out_reg = 1'b1;
        default: out_reg = 1'b0;
    endcase
end

assign out = out_reg;
endmodule
