module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

reg [3:0] state, next_state;
    
localparam A = 0;
localparam B = 1;
localparam C = 2;
localparam S10 = 3;
localparam S11 = 4;
localparam S20 = 5;
localparam S21 = 6;
localparam S22 = 7;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= A;
    end else begin
        state <= next_state;
    end
    
    case (state)
        A: begin
            if (s) begin
                next_state <= B;
            end
        end
        
        B: begin
            if (w) begin
                next_state <= S11;
            end else begin
                next_state <= S10;
            end
        end
        
        C: begin
            if (w) begin
                next_state <= S11;
            end else begin
                next_state <= S10;
            end
        end
        
        S10: begin
            if (w) begin
                next_state <= S21;
            end else begin
                next_state <= S20;
            end
        end
        
        S11: begin
            if (w) begin
                next_state <= S22;
            end else begin
                next_state <= S21;
            end
        end
        
        S20: begin
            next_state <= B;
        end
        
        S21: begin
            if (w) begin
                next_state <= C;
            end else begin
                next_state <= B;
            end
        end
        
        S22: begin
            if (w) begin
                next_state <= B;
            end else begin
                next_state <= C;
            end
        end
    endcase
end

always @(posedge clk) begin
    if (reset) begin
        z <= 0;
    end else begin
        case (state)
            A, B, C: begin
                z <= 0;
            end
            
            S10, S11, S20, S21, S22: begin
                z <= 1;
            end
        endcase
    end
end

endmodule
