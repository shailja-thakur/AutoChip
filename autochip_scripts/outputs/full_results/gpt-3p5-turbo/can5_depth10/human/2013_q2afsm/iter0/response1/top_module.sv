module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output [3:1] g
);
    
    reg [1:0] current_state, next_state;
    
    // State codes
    parameter A = 2'b00;
    parameter B = 2'b01;
    parameter C = 2'b10;
    parameter D = 2'b11;
    
    // Outputs
    assign g[1] = (current_state == B);
    assign g[2] = (current_state == C);
    assign g[3] = (current_state == D);
    
    always @(posedge clk or negedge resetn) begin
        if (~resetn) begin
            current_state <= A;
        end else begin
            current_state <= next_state;
        end
    end
    
    always @* begin
        case (current_state)
            A: begin
                if (r[1] && ~r[2] && ~r[3]) begin
                    next_state = A;
                end else if (r[1]) begin
                    next_state = B;
                end else if (~r[1] && r[2]) begin
                    next_state = C;
                end else if (~r[1] && ~r[2] && ~r[3]) begin
                    next_state = D;
                end
            end
            B: begin
                if (r[1]) begin
                    next_state = B;
                end else if (~r[1]) begin
                    next_state = A;
                end
            end
            C: begin
                if (r[2]) begin
                    next_state = C;
                end else if (~r[2]) begin
                    next_state = A;
                end
            end
            D: begin
                if (~r[1] && ~r[2] && ~r[3]) begin
                    next_state = D;
                end else begin
                    next_state = A;
                end
            end
        endcase
    end
    
endmodule
