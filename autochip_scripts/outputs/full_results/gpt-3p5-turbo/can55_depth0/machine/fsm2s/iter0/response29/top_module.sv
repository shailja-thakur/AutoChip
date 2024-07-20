module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

    reg [1:0] state;
    
    always @(posedge clk, posedge reset) begin
        if (reset)
            state <= 2'b00;  // initialize state to A
        else
            case (state)
                2'b00: begin  // state A
                    if (j)
                        state <= 2'b01;  // transition to state B if j is high
                end
                2'b01: begin  // state B
                    if (k)
                        state <= 2'b00;  // transition to state A if k is high
                end
            endcase
    end
    
    always @(state) begin
        if (state == 2'b01)
            out <= 1'b1;  // output is high when state is B
        else
            out <= 1'b0;  // output is low when state is A
    end
    
endmodule
