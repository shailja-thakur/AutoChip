module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    reg [1:0] state, next_state;
    
    always @(posedge clk) begin
        if (reset)
            state <= 2'b10;
        else
            state <= next_state;
    end
    
    always @(state, in) begin
        case (state)
            2'b00: begin
                if (in)
                    next_state = 2'b01;
                else
                    next_state = 2'b10;
                out = 1'b1;
            end
            
            2'b01: begin
                if (in)
                    next_state = 2'b01;
                else
                    next_state = 2'b00;
                out = 1'b1;
            end
            
            2'b10: begin
                if (in)
                    next_state = 2'b10;
                else
                    next_state = 2'b00;
                out = 1'b0;
            end
            
            default: begin
                next_state = 2'b00;
                out = 1'b0;
            end
        endcase
    end
    
endmodule
