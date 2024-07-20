module top_module (
    input clk,
    input areset,
    input x,
    output z
);

    reg [1:0] state, next_state;
    
    parameter A = 2'b00;
    parameter B = 2'b01;
    
    initial begin
        state = A;
        next_state = A;
        z = 0;
    end
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= A;
            z <= 0;
        end
        else begin
            state <= next_state;
            z <= (state == B) ? 1'b0 : 1'b1;
        end
    end
    
    always @(state, x) begin
        case (state)
            A: begin
                if (x)
                    next_state = B;
                else
                    next_state = A;
            end
            B: begin
                if (x)
                    next_state = B;
                else
                    next_state = B;
            end
        endcase
    end
endmodule
