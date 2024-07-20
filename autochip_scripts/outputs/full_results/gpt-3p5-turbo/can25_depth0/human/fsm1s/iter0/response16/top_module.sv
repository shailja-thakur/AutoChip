module top_module (
    input clk,
    input in,
    input reset,
    output out
);

reg [1:0] state;
    
always @(posedge clk or posedge reset) begin
    if (reset)
        state <= 2'b00; // reset state B
    else begin
        case(state)
            2'b00: begin // state B
                if (in)
                    state <= 2'b00; // remain in state B
                else
                    state <= 2'b01; // transition to state A
            end
            2'b01: begin // state A
                if (in)
                    state <= 2'b01; // remain in state A
                else
                    state <= 2'b00; // transition to state B
            end
        endcase
    end
end
    
always @(state) begin
    case(state)
        2'b00: out = 1'b1; // output 1 in state B
        2'b01: out = 1'b0; // output 0 in state A
    endcase
end

endmodule
