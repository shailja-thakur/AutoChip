module top_module (
    input clk,
    input in,
    input areset,
    output out
);
    reg [1:0] state, next_state;
    reg out_reg;
    
    parameter A = 2'b00;
    parameter B = 2'b01;
    parameter C = 2'b10;
    parameter D = 2'b11;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= A;
            out_reg <= 0;
        end
        else begin
            state <= next_state;
            out_reg <= (state == D) ? 1 : 0;
        end
    end
    
    always @(state, in) begin
        case(state)
            A: begin
                next_state = in ? B : A;
            end
            B: begin
                next_state = in ? B : C;
            end
            C: begin
                next_state = in ? D : A;
            end
            D: begin
                next_state = in ? B : C;
            end
        endcase
    end
    
    assign out = out_reg;
    
endmodule
