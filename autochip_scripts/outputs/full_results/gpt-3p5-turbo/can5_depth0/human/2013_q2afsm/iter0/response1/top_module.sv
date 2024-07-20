module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output [3:1] g
);
  
    // State definition
    typedef enum logic [1:0] {
        A, B, C, D
    } state_t;
  
    // Outputs
    assign g = {1'b0, g2, g1};
  
    // Registers
    reg state_t current_state, next_state;
    reg g1, g2;
  
    // State table
    always @(posedge clk or negedge resetn) begin
        if (~resetn) begin
            current_state <= A;
        end else begin
            current_state <= next_state;
        end
    end
  
    // Next state logic
    always @(*) begin
        next_state = current_state;
        g1 = 0;
        g2 = 0;
      
        case (current_state)
            A:
                if (r[1] == 1'b1 && r[2] == 1'b1 && r[3] == 1'b1) begin
                    next_state = A;
                end else if (r[1] == 1'b1 && r[2] == 1'b0 && r[3] == 1'b0) begin
                    next_state = B;
                    g1 = 1;
                end else if (r[1] == 1'b0 && r[2] == 1'b1 && r[3] == 1'b0) begin
                    next_state = C;
                    g2 = 1;
                end else if (r[1] == 1'b0 && r[2] == 1'b0 && r[3] == 1'b0) begin
                    next_state = D;
                end
            B:
                if (r[1] == 1'b1) begin
                    next_state = B;
                end else begin
                    next_state = A;
                end
            C:
                if (r[2] == 1'b1) begin
                    next_state = C;
                end else begin
                    next_state = A;
                end
            D:
                next_state = A;
        endcase
    end
  
endmodule
