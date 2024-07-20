module top_module (
    input clock,
    input a,
    output reg p,
    output reg q
);

reg [1:0] state;
parameter S0 = 2'b00, 
          S1 = 2'b01, 
          S2 = 2'b10, 
          S3 = 2'b11;

always @(posedge clock) begin
    case (state)
        S0: begin
            if (a == 1'b1) begin
                state <= S1;
            end else begin
                state <= S0;
            end
        end
        
        S1: begin
            state <= S2;
        end
        
        S2: begin
            state <= S1;
        end
        
        S3: begin
            state <= S0;
        end
    endcase
end

always @(state) begin
    case (state)
        S0, S3: begin
            p <= 1'b0;
            q <= 1'b0;
        end
        
        S1: begin
            p <= 1'b1;
            q <= 1'b0;
        end
        
        S2: begin
            p <= 1'b1;
            q <= 1'b1;
        end
    endcase
end

endmodule
