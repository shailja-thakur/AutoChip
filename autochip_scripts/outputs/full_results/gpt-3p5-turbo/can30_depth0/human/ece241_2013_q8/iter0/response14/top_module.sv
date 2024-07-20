module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

    // Define states
    parameter S0 = 0;
    parameter S1 = 1;
    parameter S2 = 2;
    
    // Define state variable
    reg [1:0] state;
    
    // Next state logic
    always @(posedge clk or negedge aresetn) begin
        if (~aresetn)
            state <= S0;
        else
            case(state)
                S0: if (x == 1'b1)
                        state <= S1;
                     else
                        state <= S0;
                S1: if (x == 1'b0)
                        state <= S0;
                     else
                        state <= S2;
                S2: if (x == 1'b1)
                        state <= S0;
                     else
                        state <= S1;
            endcase
    end
    
    // Output logic
    always @(posedge clk or negedge aresetn) begin
        if (~aresetn)
            z <= 1'b0;
        else
            if (state == S2 && x == 1'b1)
                z <= 1'b1;
            else
                z <= 1'b0;
    end
    
endmodule
