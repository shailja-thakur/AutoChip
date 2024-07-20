module top_module (
    input in,
    input wire clk,
    input [9:0] state,
    output reg [9:0] next_state,
    output reg out1,
    output reg out2);
    
    reg [9:0] next_state_temp;
    
    always @(state, in) begin
        case(state)
            10'b0000000001: next_state_temp = 10'b0000000001 & ~in;
            10'b0000000001: next_state_temp = 10'b0000000001 & in;
            10'b0000000010: next_state_temp = 10'b0000000010 & ~in;
            10'b0000000010: next_state_temp = 10'b0000000010 & in;
            10'b0000000100: next_state_temp = 10'b0000000100 & ~in;
            10'b0000000100: next_state_temp = 10'b0000000100 & in;
            10'b0000001000: next_state_temp = 10'b0000001000 & ~in;
            10'b0000001000: next_state_temp = 10'b0000001000 & in;
            10'b0000010000: next_state_temp = 10'b0000010000 & ~in;
            10'b0000010000: next_state_temp = 10'b0000010000 & in;
            default: next_state_temp = 10'b0;
        endcase
    end
    
    always @(posedge clk) begin
        next_state <= next_state_temp;
        
        case(state)
            10'b1101000000: begin
                out1 <= ~in;
                out2 <= 1'b0;
            end
            10'b1110000000: begin
                out1 <= (~in) & (state[7]);
                out2 <= in;
            end
            10'b0000000000: begin
                out1 <= 1'b0;
                out2 <= 1'b0;
            end
            default: begin
                out1 <= 1'b0;
                out2 <= 1'b0;
            end
        endcase
    end
    
endmodule
