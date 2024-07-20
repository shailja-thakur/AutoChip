module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output [3:1] g
);

    // Define states
    parameter A = 2'b00;
    parameter B = 2'b01;
    parameter C = 2'b10;
    parameter D = 2'b11;
    
    // Define state register
    reg [1:0] state_reg;
    reg [1:0] next_state_reg;
    
    // Define next state logic
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            state_reg <= A;
        end else begin
            state_reg <= next_state_reg;
        end
    end
    
    // Define state transition logic
    always @(*) begin
        case (state_reg)
            A: begin
                if (r[1] == 1'b1) begin
                    next_state_reg = B;
                end else if (r[2] == 1'b1) begin
                    next_state_reg = C;
                end else if (r[3] == 1'b1) begin
                    next_state_reg = D;
                end else begin
                    next_state_reg = A;
                end
            end
            
            B: begin
                if (r[1] == 1'b1) begin
                    next_state_reg = B;
                end else begin
                    next_state_reg = A;
                end
            end
            
            C: begin
                if (r[2] == 1'b1) begin
                    next_state_reg = C;
                end else begin
                    next_state_reg = A;
                end
            end
            
            D: begin
                if (r[1] == 1'b1 || r[2] == 1'b1 || r[3] == 1'b1) begin
                    next_state_reg = D;
                end else begin
                    next_state_reg = A;
                end
            end
        endcase
    end
    
    // Generate outputs
    always @(state_reg) begin
        case (state_reg)
            A: g = 3'b000;
            B: g = 3'b100;
            C: g = 3'b010;
            D: g = 3'b001;
        endcase
    end

endmodule
