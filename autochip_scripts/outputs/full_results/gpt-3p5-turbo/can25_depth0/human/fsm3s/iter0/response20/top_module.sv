module top_module (
    input clk,
    input in,
    input reset,
    output out
);
 
reg [1:0] state;
reg out;
 
always @(posedge clk or posedge reset) begin
    if (reset)
        state <= 2'b00; // Reset to state A
    else begin
        case (state)
            2'b00: begin // State A
                if (in)
                    state <= 2'b01; // Next state in=1 -> State B
                else
                    state <= 2'b00; // Next state in=0 -> State A
            end
 
            2'b01: begin // State B
                if (in)
                    state <= 2'b01; // Next state in=1 -> State B
                else
                    state <= 2'b10; // Next state in=0 -> State C
            end
 
            2'b10: begin // State C
                if (in)
                    state <= 2'b00; // Next state in=1 -> State A
                else
                    state <= 2'b11; // Next state in=0 -> State D
            end
 
            2'b11: begin // State D
                if (in)
                    state <= 2'b10; // Next state in=1 -> State C
                else
                    state <= 2'b01; // Next state in=0 -> State B
            end
        endcase
    end
end
 
always @(state) begin
    case (state)
        2'b00: out = 1'b0; // Output for State A
        2'b01: out = 1'b0; // Output for State B
        2'b10: out = 1'b0; // Output for State C
        2'b11: out = 1'b1; // Output for State D
    endcase
end
 
endmodule
