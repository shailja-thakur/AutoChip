module top_module (
	input clk,
	input aresetn,
	input x,
    output reg z
);
    parameter S0 = 0;
    parameter S1 = 1;
    parameter S2 = 2;
    
    reg [1:0] state;
    
    always @(posedge clk or negedge aresetn) begin
        if (!aresetn) begin
            state <= S0;
            z <= 0;
        end else begin
            case (state)
                S0: begin
                    if (x) begin
                        state <= S1;
                    end
                end
                S1: begin
                    if (x) begin
                        state <= S1;
                    end else begin
                        state <= S2;
                    end
                end
                S2: begin
                    if (x) begin
                        state <= S1;
                        z <= 1;
                    end else begin
                        state <= S2;
                    end
                end
            endcase
        end
    end
endmodule
