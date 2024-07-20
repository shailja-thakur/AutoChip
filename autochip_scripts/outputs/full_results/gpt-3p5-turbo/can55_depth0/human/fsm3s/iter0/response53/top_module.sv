module top_module (
	input clk,
	input in,
	input reset,
	output out
);
    reg [1:0] state;
    reg out_reg;
    
    parameter A = 2'b00;
    parameter B = 2'b01;
    parameter C = 2'b10;
    parameter D = 2'b11;
    
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= A;
        else begin
            case (state)
                A: begin
                    if (in)
                        state <= B;
                    else 
                        state <= A;
                end
                B: begin
                    if (in)
                        state <= B;
                    else 
                        state <= C;
                end
                C: begin
                    if (in)
                        state <= D;
                    else 
                        state <= A;
                end
                D: begin
                    if (in)
                        state <= B;
                    else 
                        state <= C;
                end
            endcase
        end
    end
    
    always @(state) begin
        case (state)
            A: out_reg = 1'b0;
            B: out_reg = 1'b0;
            C: out_reg = 1'b0;
            D: out_reg = 1'b1;
        endcase
    end
    
    assign out = out_reg;
    
endmodule
