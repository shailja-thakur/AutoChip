module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);
    
    reg [1:0] state;
    
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= 2'b00;  // Reset state OFF
        else begin
            case (state)
                2'b00: begin  // OFF state
                    if (j)
                        state <= 2'b01;  // Transition to ON state
                end
                2'b01: begin  // ON state
                    if (k)
                        state <= 2'b00;  // Transition to OFF state
                end
            endcase
        end
    end
    
    always @(state) begin
        case (state)
            2'b00: out = 1'b0;  // OFF state, out=0
            2'b01: out = 1'b1;  // ON state, out=1
        endcase
    end
    
endmodule
