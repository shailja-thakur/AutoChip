module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

// State definitions
parameter S0 = 0;
parameter S1 = 1;
parameter S2 = 2;

// State register
reg [1:0] state;
// Next state logic
always @(posedge clk or negedge aresetn) begin
    if(~aresetn)
        state <= S0;
    else
        case(state)
            S0: if(x==0)
                    state <= S0;
                else if(x==1)
                    state <= S1;
                else
                    state <= S0;
            S1: if(x==0)
                    state <= S2;
                else if(x==1)
                    state <= S1;
                else
                    state <= S0;
            S2: if(x==0)
                    state <= S0;
                else if(x==1)
                    state <= S2;
                else
                    state <= S0;
        endcase
end

// Output logic
always @(state, x) begin
    if(state == S2 && x == 1)
        z <= 1;
    else
        z <= 0;
end

endmodule
