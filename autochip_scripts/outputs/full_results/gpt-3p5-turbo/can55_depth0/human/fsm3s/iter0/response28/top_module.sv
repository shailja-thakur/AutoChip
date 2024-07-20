module top_module (
    input clk,
    input in,
    input reset,
    output out
);

    reg [1:0] state, next_state;
    
    always@(posedge clk or posedge reset) begin
        if (reset)
            state <= 2'b00;
        else
            state <= next_state;
    end
    
    always@(state or in) begin
        case (state)
            2'b00:
                if (in)
                    next_state = 2'b01;
                else
                    next_state = 2'b10;
            2'b01:
                if (in)
                    next_state = 2'b10;
                else
                    next_state = 2'b01;
            2'b10:
                if (in)
                    next_state = 2'b00;
                else
                    next_state = 2'b11;
            2'b11:
                if (in)
                    next_state = 2'b10;
                else
                    next_state = 2'b01;
        endcase
    end
    
    always@(state) begin
        case (state)
            2'b00: 
                out = 1'b0;
            2'b01:
                out = 1'b0;
            2'b10:
                out = 1'b0;
            2'b11:
                out = 1'b1;
        endcase
    end

endmodule
