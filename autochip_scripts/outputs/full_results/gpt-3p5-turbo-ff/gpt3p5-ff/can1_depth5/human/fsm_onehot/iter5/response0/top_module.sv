module top_module (
    input wire in,
    input wire clk,
    input wire [9:0] state,
    output reg [9:0] next_state,
    output reg out1,
    output reg out2);
    
    always @(posedge clk) begin
        case(state)
            10'b0000000001: next_state <= 10'b0000000001 & ~in;
            10'b0000000001: next_state <= 10'b0000000001 & in;
            10'b0000000010: next_state <= 10'b0000000010 & ~in;
            10'b0000000010: next_state <= 10'b0000000010 & in;
            10'b0000000100: next_state <= 10'b0000000100 & ~in;
            10'b0000000100: next_state <= 10'b0000000100 & in;
            10'b0000001000: next_state <= 10'b0000001000 & ~in;
            10'b0000001000: next_state <= 10'b0000001000 & in;
            10'b0000010000: next_state <= 10'b0000010000 & ~in;
            10'b0000010000: next_state <= 10'b0000010000 & in;
            default: next_state <= 10'b0;
        endcase
    end
    
    always @(state, in) begin
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
