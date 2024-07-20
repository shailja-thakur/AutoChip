module top_module (
	input clk,
	input areset,
	input x,
	output z
);

    parameter A = 1'b0;
    parameter B = 1'b1;
    
    reg state;
    
    always @(posedge clk or negedge areset) begin
        if (areset == 0)
            state <= A;
        else begin
            case (state)
                A: begin
                    if (x == 1)
                        state <= B;
                    else
                        state <= A;
                end
                B: state <= B;
            endcase
        end
    end
    
    assign z = (state == A && x == 1) || (state == B && x == 0);
    
endmodule
