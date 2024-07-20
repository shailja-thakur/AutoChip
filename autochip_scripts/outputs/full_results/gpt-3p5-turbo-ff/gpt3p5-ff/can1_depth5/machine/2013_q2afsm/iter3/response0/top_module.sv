module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output reg [3:1] g
);
    reg [1:0] state, next;
    parameter A = 2'b00;
    parameter B = 2'b01;
    parameter C = 2'b10;
    parameter D = 2'b11;
    
    always @(posedge clk) begin
        if (!resetn) begin
            state <= A;
        end else begin
            state <= next;
        end
    end
    
    always @(*) begin
        case (state)
            A: begin
                if (r[1]) begin
                    next = B;
                end else if (r[2]) begin
                    next = C;
                end else if (r[3]) begin
                    next = D;
                end else begin
                    next = A;
                end
            end
            
            B: begin
                if (r[1]) begin
                    next = B;
                end else begin
                    next = A;
                end
            end
            
            C: begin
                if (r[2]) begin
                    next = C;
                end else begin
                    next = A;
                end
            end
            
            D: begin
                if (r[3]) begin
                    next = D;
                end else begin
                    next = A;
                end
            end
        endcase
    end
    
    always @(state) begin
        case (state)
            B: g = 3'b001;
            C: g = 3'b010;
            D: g = 3'b100;
            default: g = 3'b000;
        endcase
    end
endmodule
