module top_module (
    input clk,
    input in,
    input areset,
    output out
);

    reg [1:0] state, next_state;

    always @(posedge clk or areset)
    begin
        if (areset)
            state <= 2'b00;
        else
            state <= next_state;
    end
    
    always @(state, in)
    begin
        case (state)
            2'b00: begin
                if (in)
                    next_state = 2'b01;  // A -> B
                else
                    next_state = 2'b00;  // A -> A
                out = 1'b0;
            end
            
            2'b01: begin
                if (in)
                    next_state = 2'b01;  // B -> B
                else
                    next_state = 2'b10;  // B -> C
                out = 1'b0;
            end
            
            2'b10: begin
                if (in)
                    next_state = 2'b11;  // C -> D
                else
                    next_state = 2'b00;  // C -> A
                out = 1'b0;
            end
            
            2'b11: begin
                if (in)
                    next_state = 2'b01;  // D -> B
                else
                    next_state = 2'b10;  // D -> C
                out = 1'b1;
            end
        endcase
    end
    
endmodule
