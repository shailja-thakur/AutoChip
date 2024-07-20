module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output f,
	output g
);

    reg [2:0] current_state, next_state;
    
    parameter A = 3'b000;
    parameter B = 3'b001;
    parameter S0 = 3'b010;
    parameter S1 = 3'b011;
    parameter S10 = 3'b100;
    parameter G1 = 3'b101;
    parameter G2 = 3'b110;
    parameter P0 = 3'b111;
    parameter P1 = 3'b000;
    
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            current_state <= A;
        end else begin
            current_state <= next_state;
        end
    end
    
    always @(current_state or x or y) begin
        case (current_state)
            A: begin
                if (x) begin
                    next_state = B;
                end else begin
                    next_state = S0;
                end
            end
            
            B: begin
                next_state = S0;
            end
            
            S0: begin
                if (x) begin
                    next_state = S1;
                end else begin
                    next_state = S0;
                end
            end
            
            S1: begin
                if (x) begin
                    next_state = S1;
                end else begin
                    next_state = S10;
                end
            end
            
            S10: begin
                if (x) begin
                    next_state = G1;
                end else begin
                    next_state = S0;
                end
            end
            
            G1: begin
                if (y) begin
                    next_state = P1;
                end else begin
                    next_state = G2;
                end
            end
            
            G2: begin
                if (y) begin
                    next_state = P1;
                end else begin
                    next_state = P0;
                end
            end
            
            P0: begin
                next_state = P0;
            end
            
            P1: begin
                next_state = P1;
            end
            
            default: begin
                next_state = A;
            end
        endcase
    end
    
    assign f = (current_state == B) ? 1'b1 : 1'b0;
    assign g = (current_state == G1 || current_state == G2 || current_state == P1) ? 1'b1 : 1'b0;

endmodule
