module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output f,
    output g
);

    reg [1:0] state, next_state;
    
    assign f = (state == 2'b01) & (next_state != 2'b01);
    assign g = (state == 2'b10);
    
    always @(posedge clk) begin
        if (!resetn)
            state <= 2'b00;
        else
            state <= next_state;
    end
    
    always @(state, x, y) begin
        case (state)
            2'b00: begin
                if (resetn)
                    next_state = 2'b01;
                else
                    next_state = 2'b00;
            end
            2'b01: begin
                if (x == 1'b1)
                    next_state = 2'b10;
                else
                    next_state = 2'b01;
            end
            2'b10: begin
                if (y == 1'b1)
                    next_state = 2'b10;
                else
                    next_state = 2'b00;
            end
            default: next_state = 2'b00;
        endcase
    end
endmodule
