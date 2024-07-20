module top_module (
    input clk,
    input a,
    input b,
    output q,
    output state
);

    reg q;
    reg state;
    reg next_q;
    reg next_state;
    
    always @(posedge clk) begin
        q <= next_q;
        state <= next_state;
    end
    
    always @(a, b, state) begin
        case (state)
            0: begin
                next_state = (a & (~b)) ? 1 : 0;
                next_q = 0;
            end
            1: begin
                next_state = (a | (~b)) ? 0 : 1;
                next_q = 1;
            end
            default: begin
                next_state = 0;
                next_q = 0;
            end
        endcase
    end
    
    assign q = next_q;
    assign state = next_state;
    
endmodule
