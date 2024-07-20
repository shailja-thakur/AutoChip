module fsm_module (
    input wire clk,
    input wire reset,
    input wire w,
    output wire z
);

    reg [2:0] state, nextstate;
    
    parameter A = 0, B = 1, C = 2, D = 3, E = 4, F = 5;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= A;
        end else begin
            state <= nextstate;
        end
    end
    
    always @(state or w) begin
        case (state)
            A: begin
                if (w == 1'b0) begin
                    nextstate = B;
                end else begin
                    nextstate = A;
                end
            end
            
            B: begin
                if (w == 1'b0) begin
                    nextstate = C;
                end else begin
                    nextstate = D;
                end
            end
            
            C: begin
                if (w == 1'b0) begin
                    nextstate = E;
                end else begin
                    nextstate = D;
                end
            end
            
            D: begin
                if (w == 1'b0) begin
                    nextstate = F;
                end else begin
                    nextstate = A;
                end
            end
            
            E: begin
                if (w == 1'b0) begin
                    nextstate = E;
                end else begin
                    nextstate = D;
                end
            end
            
            F: begin
                if (w == 1'b0) begin
                    nextstate = C;
                end else begin
                    nextstate = D;
                end
            end
        endcase
    end
    
    always @(posedge clk) begin
        case (state)
            A, B, C, D: begin
                z <= 1'b0;
            end
            E, F: begin
                z <= 1'b1;
            end
        endcase
    end
    
endmodule
module top_module (
    input wire clk,
    input wire reset,
    input wire w,
    output wire z
);
    
    fsm_module fsm_inst (
        .clk(clk),
        .reset(reset),
        .w(w),
        .z(z)
    );
    
endmodule
