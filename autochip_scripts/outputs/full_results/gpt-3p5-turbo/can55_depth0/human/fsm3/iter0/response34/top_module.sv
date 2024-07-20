module top_module(
    input clk,
    input in,
    input areset,
    output out
);

    reg [1:0] state_reg, state_next;
    reg out_reg;
    
    parameter A = 2'b00;
    parameter B = 2'b01;
    parameter C = 2'b10;
    parameter D = 2'b11;
    
    always @(posedge clk or posedge areset) begin
        if (areset == 1'b1) begin
            state_reg <= A;
            out_reg <= 1'b0;
        end
        else begin
            state_reg <= state_next;
            out_reg <= (state_next == D) ? 1'b1 : 1'b0;
        end
    end
    
    always @(*) begin
        case (state_reg)
            A: begin
                state_next = (in == 1'b1) ? B : A;
            end
            B: begin
                state_next = (in == 1'b1) ? B : C;
            end
            C: begin
                state_next = (in == 1'b1) ? D : A;
            end
            D: begin
                state_next = (in == 1'b1) ? B : C;
            end
            default: begin
                state_next = A;
            end
        end
    end
    
    assign out = out_reg;
    
endmodule
