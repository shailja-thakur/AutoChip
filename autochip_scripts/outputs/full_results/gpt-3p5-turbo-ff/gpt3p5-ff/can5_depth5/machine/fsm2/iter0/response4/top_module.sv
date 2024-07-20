module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

    reg [1:0] state;  // FSM states
    
    always @ (j or state)
        if (state == 2'b00)  // current state is A
            state = (j) ? 2'b01 : 2'b00;  // next state is B if j is high, otherwise A
        else if (state == 2'b01)  // current state is B
            state = (k) ? 2'b00 : 2'b01;  // next state is A if k is high, otherwise B
    
    always @(posedge clk or posedge areset)
        if (areset)
            state <= 2'b00;  // reset state to A
        else
            state <= state;  // update state to the next state
    
    assign out = (state == 2'b01) ? 1'b1 : 1'b0;  // out port indicates the current state, B is high, otherwise low

endmodule
