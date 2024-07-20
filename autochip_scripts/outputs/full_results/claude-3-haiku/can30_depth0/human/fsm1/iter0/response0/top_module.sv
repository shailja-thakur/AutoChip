module top_module (
    input clk,
    input in,
    input areset,
    output out
);

    reg state, next_state;
    
    localparam A = 1'b0;
    localparam B = 1'b1;
    
    always @(posedge clk, posedge areset) begin
        if (areset)
            state <= B;
        else
            state <= next_state;
    end
    
    always @(*) begin
        case (state)
            B: begin
                if (in == 0)
                    next_state = A;
                else
                    next_state = B;
            end
            A: begin
                if (in == 0)
                    next_state = B;
                else
                    next_state = A;
            end
        endcase
    end
    
    assign out = (state == A) ? 1'b0 : 1'b1;

endmodule
