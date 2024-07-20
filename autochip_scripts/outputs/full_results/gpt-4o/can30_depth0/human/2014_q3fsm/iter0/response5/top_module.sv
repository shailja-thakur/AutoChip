module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    reg [2:0] state, next_state;
    reg [1:0] w_count;
    
    // State Encoding
    localparam A = 3'b000,
               B = 3'b001,
               C = 3'b010,
               D = 3'b011,
               E = 3'b100;
    
    // State Transition Logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= A;
            z <= 0;
            w_count <= 0;
        end else begin
            state <= next_state;
        end
    end
    
    // Next State Logic and Output Logic
    always @(*) begin
        next_state = state;
        z = 0;
        
        case (state)
            A: begin
                if (s)
                    next_state = B;
                else
                    next_state = A;
            end
            
            B: begin
                if (w_count == 2'b10) begin
                    z = 1;
                    next_state = C;
                end else begin
                    next_state = C;
                end
            end
            
            C: begin
                if (w)
                    w_count = w_count + 1;
                
                if (w_count == 2'b10) begin
                    z = 1;
                    next_state = D;
                end else begin
                    next_state = D;
                end
            end
            
            D: begin
                if (w)
                    w_count = w_count + 1;
                
                if (w_count == 2'b10) begin
                    z = 1;
                    next_state = E;
                end else begin
                    next_state = E;
                end
            end
            
            E: begin
                if (w)
                    w_count = w_count + 1;
                
                if (w_count == 2'b10) begin
                    z = 1;
                end else begin
                    z = 0;
                end
                
                next_state = A;
                w_count = 0;
            end
        endcase
    end
endmodule
